import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/data/models/package_filters.dart';
import 'package:by_lety_travels/presentation/widgets/travel_package_card.dart';
import 'package:by_lety_travels/presentation/widgets/components/package_filters_widget.dart';
import 'package:by_lety_travels/presentation/widgets/package_details_modal.dart';

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

  @override
  void initState() {
    super.initState();
    _filteredPackages = widget.allPackages;
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
    });
  }

  /// Check if package matches duration filter
  bool _matchesDuration(int days, String durationFilter) {
    switch (durationFilter) {
      case '3-5 days':
        return days >= 3 && days <= 5;
      case '6-8 days':
        return days >= 6 && days <= 8;
      case '9+ days':
        return days >= 9;
      default:
        return true;
    }
  }

  /// Check if package has a specific service
  bool _packageHasService(PackageTravel package, String service) {
    switch (service) {
      case 'Flights':
        return package.flightsIncluded;
      case 'Hotel 5★':
        return package.hotelRating.contains('5');
      case 'Guided Tours':
        return package.guidedTours;
      case 'Meals Included':
        return package.services.contains('Meals Included');
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

    return Container(
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
                      'Explore Our Packages',
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
                          '${_filteredPackages.length} ${_filteredPackages.length == 1 ? 'package' : 'packages'} available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (!isMobile) ...[
                          const SizedBox(width: 24),
                          Icon(Icons.sort, size: 20, color: Colors.grey[600]),
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
                    _showFilters ? Icons.filter_list_off : Icons.filter_list,
                  ),
                  label: Text(_showFilters ? 'Hide Filters' : 'Show Filters'),
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
                          Icon(Icons.sort, size: 20, color: Colors.grey[600]),
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
                    Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
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
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
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
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: isMobile ? 0.85 : 0.75,
      ),
      itemCount: _filteredPackages.length,
      itemBuilder: (context, index) {
        final package = _filteredPackages[index];

        // Calculate discount info
        String? originalPrice;
        if (package.hasDiscount && package.originalPrice != null) {
          originalPrice = '\$${package.originalPrice!.toStringAsFixed(0)}';
        }

        return TravelPackageCard(
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
            print('Book Now pressed for: ${package.title}');
            // TODO: Navigate to booking page
          },
          onViewDetailsPressed: () {
            // Show package details modal
            showDialog(
              context: context,
              builder: (context) => PackageDetailsModal(package: package),
            );
          },
        );
      },
    );
  }
}
