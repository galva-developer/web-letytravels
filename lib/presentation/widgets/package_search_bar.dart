import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';

class PackageSearchBar extends StatefulWidget {
  final VoidCallback? onSearchResultsPage;

  const PackageSearchBar({super.key, this.onSearchResultsPage});

  @override
  State<PackageSearchBar> createState() => _PackageSearchBarState();
}

class _PackageSearchBarState extends State<PackageSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _showSuggestionsOverlay();
    } else {
      // Delay to allow clicking on suggestions
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!_focusNode.hasFocus) {
          _removeOverlay();
        }
      });
    }
  }

  void _showSuggestionsOverlay() {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _showSuggestions = true);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _showSuggestions = false);
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder:
          (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 5),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Consumer<SearchProvider>(
                  builder: (context, searchProvider, child) {
                    final suggestions = searchProvider.getSuggestions(
                      _searchController.text,
                    );

                    if (suggestions.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Container(
                      constraints: const BoxConstraints(maxHeight: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = suggestions[index];
                          final isHistory = searchProvider.searchHistory
                              .contains(suggestion);

                          return ListTile(
                            dense: true,
                            leading: Icon(
                              isHistory ? Icons.history : Icons.search,
                              color: const Color(0xFF072A47),
                              size: 20,
                            ),
                            title: _buildHighlightedText(
                              suggestion,
                              _searchController.text,
                            ),
                            trailing:
                                isHistory
                                    ? IconButton(
                                      icon: const Icon(Icons.close, size: 18),
                                      onPressed: () {
                                        searchProvider.removeFromHistory(
                                          suggestion,
                                        );
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    )
                                    : null,
                            onTap: () {
                              _searchController.text = suggestion;
                              searchProvider.executeSearch(suggestion);
                              _removeOverlay();
                              _focusNode.unfocus();
                              widget.onSearchResultsPage?.call();
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return Text(text);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final index = lowerText.indexOf(lowerQuery);

    if (index == -1) {
      return Text(text);
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        children: [
          TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF072A47),
            ),
          ),
          TextSpan(text: text.substring(index + query.length)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          return Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Buscar destinos, países, paquetes...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF072A47)),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (searchProvider.isSearching)
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF072A47),
                                    ),
                                  ),
                                ),
                              ),
                            IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                searchProvider.clearSearch();
                                _removeOverlay();
                              },
                              color: Colors.grey[600],
                            ),
                          ],
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                searchProvider.updateQuery(value);
                if (_showSuggestions) {
                  _removeOverlay();
                  _showSuggestionsOverlay();
                }
                setState(() {});
              },
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  searchProvider.executeSearch(value);
                  _removeOverlay();
                  _focusNode.unfocus();
                  widget.onSearchResultsPage?.call();
                }
              },
              textInputAction: TextInputAction.search,
            ),
          );
        },
      ),
    );
  }
}
