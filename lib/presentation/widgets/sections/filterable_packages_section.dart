import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/data/models/package_filters.dart';
import 'package:by_lety_travels/presentation/widgets/travel_package_card.dart';
import 'package:by_lety_travels/presentation/widgets/components/package_filters_widget.dart';
import 'package:by_lety_travels/presentation/widgets/package_details_modal.dart';
import 'package:by_lety_travels/presentation/pages/booking_form_page.dart';

/// Sort options for packages
enum PackageSortOption {
  mostPopular('Más Populares', Icons.star),
  priceLowToHigh('Precio: Menor a Mayor', Icons.arrow_upward),
  priceHighToLow('Precio: Mayor a Menor', Icons.arrow_downward),
  duration('Duración', Icons.schedule),
  departureDate('Próximas Salidas', Icons.calendar_today);

  final String label;
  final IconData icon;
  const PackageSortOption(this.label, this.icon);
}

/// Enhanced packages section with advanced filtering capabilities
class FilterablePackagesSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final List<PackageTravel> allPackages;

  const FilterablePackagesSection({
    super.key,
    required this.sectionKey,
    required this.allPackages,
  });

  @override
  State<FilterablePackagesSection> createState() =>
      _FilterablePackagesSectionState();
}

class _FilterablePackagesSectionState extends State<FilterablePackagesSection> {
  PackageFilters _currentFilters = const PackageFilters();
  List<PackageTravel> _filteredPackages = [];
  bool _showFilters = true;
  PackageSortOption _currentSort = PackageSortOption.mostPopular;

  // Pagination state
  int _currentPage = 1;
  final int _itemsPerPage = 9;
  bool _isLoadingPage = false;

  // Scroll state
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  int get _totalPages =>
      (_filteredPackages.length / _itemsPerPage)
          .ceil()
          .clamp(1, double.infinity)
          .toInt();

  List<PackageTravel> get _paginatedPackages {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(
      0,
      _filteredPackages.length,
    );
    return _filteredPackages.sublist(startIndex, endIndex);
  }

  @override
  void initState() {
    super.initState();
    _filteredPackages = widget.allPackages;

    // Setup scroll listener for scroll-to-top button
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final shouldShow = _scrollController.offset > 300;
        if (shouldShow != _showScrollToTop) {
          setState(() {
            _showScrollToTop = shouldShow;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FilterablePackagesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.allPackages != widget.allPackages) {
      _applyFilters(_currentFilters);
    }
  }

  /// Apply filters to the package list
  void _applyFilters(PackageFilters filters) {
    setState(() {
      _currentFilters = filters;
      _filteredPackages =
          widget.allPackages.where((package) {
            // Price filter
            if (package.priceValue < filters.minPrice ||
                package.priceValue > filters.maxPrice) {
              return false;
            }

            // Continent filter
            if (filters.selectedContinent != null &&
                filters.selectedContinent != 'All' &&
                package.continent != filters.selectedContinent) {
              return false;
            }

            // Country filter
            if (filters.selectedCountry != null &&
                package.country != filters.selectedCountry) {
              return false;
            }

            // Duration filter
            if (filters.selectedDuration != null &&
                filters.selectedDuration != 'All') {
              if (!_matchesDuration(
                package.durationDays,
                filters.selectedDuration!,
              )) {
                return false;
              }
            }

            // Category filter
            if (filters.selectedCategories.isNotEmpty &&
                !filters.selectedCategories.contains(package.category)) {
              return false;
            }

            // Services filter
            if (filters.selectedServices.isNotEmpty) {
              for (final service in filters.selectedServices) {
                if (!_packageHasService(package, service)) {
                  return false;
                }
              }
            }

            return true;
          }).toList();

      // Apply sorting
      _sortPackages();
    });
  }

  /// Sort packages based on selected option
  void _sortPackages() {
    switch (_currentSort) {
      case PackageSortOption.mostPopular:
        _filteredPackages.sort(
          (a, b) => b.popularityScore.compareTo(a.popularityScore),
        );
        break;
      case PackageSortOption.priceLowToHigh:
        _filteredPackages.sort((a, b) => a.priceValue.compareTo(b.priceValue));
        break;
      case PackageSortOption.priceHighToLow:
        _filteredPackages.sort((a, b) => b.priceValue.compareTo(a.priceValue));
        break;
      case PackageSortOption.duration:
        _filteredPackages.sort(
          (a, b) => a.durationDays.compareTo(b.durationDays),
        );
        break;
      case PackageSortOption.departureDate:
        _filteredPackages.sort((a, b) {
          // Packages without departure date go to the end
          if (a.departureDate == null && b.departureDate == null) return 0;
          if (a.departureDate == null) return 1;
          if (b.departureDate == null) return -1;
          return a.departureDate!.compareTo(b.departureDate!);
        });
        break;
    }
  }

  /// Update sort option
  void _updateSort(PackageSortOption newSort) {
    setState(() {
      _currentSort = newSort;
      _sortPackages();
      _currentPage = 1; // Reset to first page on sort change
    });
  }

  /// Pagination methods
  void _goToPage(int page) async {
    if (page < 1 || page > _totalPages || page == _currentPage) return;

    setState(() {
      _isLoadingPage = true;
    });

    // Simulate loading delay for better UX
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _currentPage = page;
      _isLoadingPage = false;
    });

    // Scroll to top of packages section
    _scrollToTop();
  }

  void _nextPage() {
    if (_currentPage < _totalPages) {
      _goToPage(_currentPage + 1);
    }
  }

  void _previousPage() {
    if (_currentPage > 1) {
      _goToPage(_currentPage - 1);
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Check if package matches duration filter
  bool _matchesDuration(int days, String durationFilter) {
    switch (durationFilter) {
      case '3-5 días':
        return days >= 3 && days <= 5;
      case '6-8 días':
        return days >= 6 && days <= 8;
      case '9+ días':
        return days >= 9;
      default:
        return true;
    }
  }

  /// Check if package has a specific service
  bool _packageHasService(PackageTravel package, String service) {
    switch (service) {
      case 'Vuelos':
        return package.flightsIncluded;
      case 'Hotel 5★':
        return package.hotelRating.contains('5');
      case 'Tours Guiados':
        return package.guidedTours;
      case 'Comidas Incluidas':
        return package.services.contains('Comidas Incluidas');
      default:
        return package.services.contains(service);
    }
  }

  /// Clear all filters
  void _clearFilters() {
    _applyFilters(const PackageFilters());
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width < 1024;

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            key: widget.sectionKey,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: 40,
            ),
            color: Colors.grey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explora Nuestros Paquetes',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 36,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF072A47),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '${_filteredPackages.length} ${_filteredPackages.length == 1 ? 'paquete' : 'paquetes'} disponibles',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!isMobile) ...[
                                const SizedBox(width: 24),
                                Icon(
                                  Icons.sort,
                                  size: 20,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 8),
                                _buildSortDropdown(),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile)
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                        icon: Icon(
                          _showFilters
                              ? Icons.filter_list_off
                              : Icons.filter_list,
                        ),
                        label: Text(
                          _showFilters ? 'Ocultar Filtros' : 'Mostrar Filtros',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF072A47),
                          side: const BorderSide(color: Color(0xFF072A47)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 32),

                // Main content area
                isMobile || isTablet
                    ? Column(
                      children: [
                        // Mobile: Sort dropdown
                        if (isMobile) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sort,
                                  size: 20,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 8),
                                Expanded(child: _buildSortDropdown()),
                              ],
                            ),
                          ),
                        ],
                        // Mobile: Filters as expandable section
                        if (_showFilters) ...[
                          PackageFiltersWidget(
                            initialFilters: _currentFilters,
                            onFiltersChanged: _applyFilters,
                            onClearFilters: _clearFilters,
                          ),
                          const SizedBox(height: 24),
                        ],
                        // Package grid
                        _buildPackageGrid(isMobile, isTablet),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Desktop: Filters sidebar
                        if (_showFilters) ...[
                          SizedBox(
                            width: 320,
                            child: PackageFiltersWidget(
                              initialFilters: _currentFilters,
                              onFiltersChanged: _applyFilters,
                              onClearFilters: _clearFilters,
                            ),
                          ),
                          const SizedBox(width: 32),
                        ],
                        // Package grid
                        Expanded(child: _buildPackageGrid(isMobile, isTablet)),
                      ],
                    ),

                // No results message
                if (_filteredPackages.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No packages found',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters to see more results',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _clearFilters,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset Filters'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFDC00),
                              foregroundColor: const Color(0xFF072A47),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Scroll to top button
        if (_showScrollToTop)
          Positioned(right: 20, bottom: 20, child: _buildScrollToTopButton()),
      ],
    );
  }

  /// Build sort dropdown widget
  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<PackageSortOption>(
        value: _currentSort,
        underline: const SizedBox(),
        isDense: true,
        icon: const Icon(Icons.keyboard_arrow_down, size: 20),
        items:
            PackageSortOption.values.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(option.icon, size: 16, color: const Color(0xFF072A47)),
                    const SizedBox(width: 8),
                    Text(option.label, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              );
            }).toList(),
        onChanged: (value) {
          if (value != null) {
            _updateSort(value);
          }
        },
      ),
    );
  }

  /// Build the package grid based on screen size
  Widget _buildPackageGrid(bool isMobile, bool isTablet) {
    return Column(
      children: [
        // Packages info and grid
        if (_isLoadingPage)
          const SizedBox(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF072A47)),
              ),
            ),
          )
        else
          Column(
            children: [
              // Package count info
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mostrando ${(_currentPage - 1) * _itemsPerPage + 1}-${((_currentPage - 1) * _itemsPerPage + _paginatedPackages.length).clamp(0, _filteredPackages.length)} de ${_filteredPackages.length} paquetes',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Grid with flexible card sizing
              LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate max card width based on screen size
                  final screenWidth = constraints.maxWidth;
                  final maxCardWidth = isMobile ? screenWidth : 620.0;
                  // Ensure minCardWidth never exceeds maxCardWidth to avoid BoxConstraints errors
                  final minCardWidth =
                      isMobile ? screenWidth.clamp(280.0, 370.0) : 620.0;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: maxCardWidth,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      mainAxisExtent:
                          isMobile
                              ? 520.0 // Reduced mobile height to eliminate bottom whitespace
                              : 650.0, // Desktop height for consistent cards
                    ),
                    itemCount: _paginatedPackages.length,
                    itemBuilder: (context, index) {
                      final package = _paginatedPackages[index];

                      // Calculate discount info
                      String? originalPrice;
                      if (package.hasDiscount &&
                          package.originalPrice != null) {
                        originalPrice =
                            '\$${package.originalPrice!.toStringAsFixed(0)}';
                      }

                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: minCardWidth,
                          maxWidth: maxCardWidth,
                        ),
                        child: TravelPackageCard(
                          title: package.title,
                          price: package.price,
                          location: package.location,
                          description: package.description,
                          duration: package.duration,
                          flightsIncluded: package.flightsIncluded,
                          hotelRating: package.hotelRating,
                          guidedTours: package.guidedTours,
                          imageUrl: package.imageUrl,
                          services: package.services,
                          hasDiscount: package.hasDiscount,
                          originalPrice: originalPrice,
                          discountPercentage: package.discountPercentage,
                          isNew: package.isNew,
                          isPopular: package.isPopular,
                          hasLimitedSeats: package.hasLimitedSeats,
                          availableSeats: package.availableSeats,
                          onBookNowPressed: () {
                            // Navigate to booking form page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        BookingFormPage(package: package),
                              ),
                            );
                          },
                          onViewDetailsPressed: () {
                            // Show package details modal
                            showDialog(
                              context: context,
                              builder:
                                  (context) =>
                                      PackageDetailsModal(package: package),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),

        // Pagination controls
        if (_totalPages > 1 && !_isLoadingPage)
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: _buildPaginationControls(),
          ),
      ],
    );
  }

  /// Build pagination controls
  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        IconButton(
          onPressed: _currentPage > 1 ? _previousPage : null,
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Anterior',
          style: IconButton.styleFrom(
            foregroundColor:
                _currentPage > 1 ? const Color(0xFF072A47) : Colors.grey,
            backgroundColor:
                _currentPage > 1 ? Colors.grey[200] : Colors.grey[100],
          ),
        ),
        const SizedBox(width: 8),

        // Page numbers
        ..._buildPageNumbers(),

        const SizedBox(width: 8),
        // Next button
        IconButton(
          onPressed: _currentPage < _totalPages ? _nextPage : null,
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Siguiente',
          style: IconButton.styleFrom(
            foregroundColor:
                _currentPage < _totalPages
                    ? const Color(0xFF072A47)
                    : Colors.grey,
            backgroundColor:
                _currentPage < _totalPages
                    ? Colors.grey[200]
                    : Colors.grey[100],
          ),
        ),
      ],
    );
  }

  /// Build page number buttons
  List<Widget> _buildPageNumbers() {
    List<Widget> pageButtons = [];
    const int maxVisiblePages = 7;

    if (_totalPages <= maxVisiblePages) {
      // Show all pages if total is small
      for (int i = 1; i <= _totalPages; i++) {
        pageButtons.add(_buildPageButton(i));
        if (i < _totalPages) {
          pageButtons.add(const SizedBox(width: 4));
        }
      }
    } else {
      // Show pages with ellipsis
      pageButtons.add(_buildPageButton(1));
      pageButtons.add(const SizedBox(width: 4));

      if (_currentPage > 3) {
        pageButtons.add(_buildEllipsis());
        pageButtons.add(const SizedBox(width: 4));
      }

      int start = (_currentPage - 1).clamp(2, _totalPages - 2);
      int end = (_currentPage + 1).clamp(2, _totalPages - 1);

      for (int i = start; i <= end; i++) {
        pageButtons.add(_buildPageButton(i));
        if (i < end) {
          pageButtons.add(const SizedBox(width: 4));
        }
      }

      if (_currentPage < _totalPages - 2) {
        pageButtons.add(const SizedBox(width: 4));
        pageButtons.add(_buildEllipsis());
      }

      pageButtons.add(const SizedBox(width: 4));
      pageButtons.add(_buildPageButton(_totalPages));
    }

    return pageButtons;
  }

  /// Build individual page button
  Widget _buildPageButton(int pageNumber) {
    final isCurrentPage = pageNumber == _currentPage;

    return InkWell(
      onTap: () => _goToPage(pageNumber),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isCurrentPage ? const Color(0xFF072A47) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCurrentPage ? const Color(0xFF072A47) : Colors.grey[300]!,
            width: isCurrentPage ? 2 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          pageNumber.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.normal,
            color: isCurrentPage ? Colors.white : const Color(0xFF072A47),
          ),
        ),
      ),
    );
  }

  /// Build ellipsis indicator
  Widget _buildEllipsis() {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        '...',
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
    );
  }

  /// Build scroll to top floating button
  Widget _buildScrollToTopButton() {
    return FloatingActionButton(
      onPressed: () {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      backgroundColor: const Color(0xFF072A47),
      foregroundColor: Colors.white,
      tooltip: 'Volver arriba',
      child: const Icon(Icons.arrow_upward),
    );
  }
}
