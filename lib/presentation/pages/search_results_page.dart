import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import '../widgets/travel_package_card.dart';
import '../widgets/package_search_bar.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF072A47),
        foregroundColor: Colors.white,
        title: const Text('Buscar Paquetes'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search bar at top
          Container(
            color: const Color(0xFF072A47),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: const PackageSearchBar(),
          ),
          // Results
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                if (!searchProvider.hasQuery) {
                  return _buildEmptyState(
                    context,
                    Icons.search,
                    'Busca tu destino ideal',
                    'Escribe el nombre de un destino, país o tipo de viaje',
                    searchProvider,
                  );
                }

                if (searchProvider.isSearching) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF072A47),
                      ),
                    ),
                  );
                }

                if (!searchProvider.hasResults) {
                  return _buildNoResults(context, searchProvider);
                }

                return _buildResults(context, searchProvider);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context, SearchProvider searchProvider) {
    final results = searchProvider.searchResults;
    final query = searchProvider.searchQuery;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results count
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Text(
                  '${results.length} ${results.length == 1 ? 'resultado' : 'resultados'}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF072A47),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'para "$query"',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Results grid
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final isMobile = screenWidth < 768;
              final maxCardWidth = isMobile ? constraints.maxWidth : 580.0;
              // Mobile: 370px minimum, Desktop: 580px minimum
              final minCardWidth = isMobile ? 370.0 : 580.0;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: maxCardWidth,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: isMobile ? 580.0 : 650.0,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final package = results[index];
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
                      hasDiscount: package.hasDiscount,
                      originalPrice:
                          package.originalPrice != null
                              ? '\$${package.originalPrice!.toStringAsFixed(0)}'
                              : null,
                      discountPercentage: package.discountPercentage,
                      isNew: package.isNew,
                      isPopular: package.isPopular,
                      hasLimitedSeats: package.hasLimitedSeats,
                      availableSeats: package.availableSeats,
                      services: package.services,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults(BuildContext context, SearchProvider searchProvider) {
    return _buildEmptyState(
      context,
      Icons.search_off,
      'No encontramos resultados',
      'Intenta buscar con otros términos o explora nuestros paquetes populares',
      searchProvider,
      showClearButton: true,
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    SearchProvider searchProvider, {
    bool showClearButton = false,
  }) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 60, color: Colors.grey[400]),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF072A47),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (showClearButton)
              ElevatedButton.icon(
                onPressed: () {
                  searchProvider.clearSearch();
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Limpiar Búsqueda'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF072A47),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            if (searchProvider.searchHistory.isNotEmpty && !showClearButton)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Búsquedas recientes:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF072A47),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        searchProvider.searchHistory.take(5).map((query) {
                          return ActionChip(
                            label: Text(query),
                            onPressed: () {
                              searchProvider.executeSearch(query);
                            },
                            backgroundColor: const Color(0xFFFFDC00),
                            labelStyle: const TextStyle(
                              color: Color(0xFF072A47),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
