// Model class to hold filter criteria for travel packages
class PackageFilters {
  final double minPrice;
  final double maxPrice;
  final String? selectedContinent;
  final String? selectedCountry;
  final String? selectedDuration;
  final Set<String> selectedCategories;
  final Set<String> selectedServices;

  const PackageFilters({
    this.minPrice = 500,
    this.maxPrice = 5000,
    this.selectedContinent,
    this.selectedCountry,
    this.selectedDuration,
    this.selectedCategories = const {},
    this.selectedServices = const {},
  });

  /// Creates a copy of the current filters with optional modifications
  PackageFilters copyWith({
    double? minPrice,
    double? maxPrice,
    String? selectedContinent,
    String? selectedCountry,
    String? selectedDuration,
    Set<String>? selectedCategories,
    Set<String>? selectedServices,
    bool clearContinent = false,
    bool clearCountry = false,
    bool clearDuration = false,
  }) {
    return PackageFilters(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      selectedContinent: clearContinent ? null : selectedContinent ?? this.selectedContinent,
      selectedCountry: clearCountry ? null : selectedCountry ?? this.selectedCountry,
      selectedDuration: clearDuration ? null : selectedDuration ?? this.selectedDuration,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedServices: selectedServices ?? this.selectedServices,
    );
  }

  /// Resets all filters to default values
  PackageFilters reset() {
    return const PackageFilters();
  }

  /// Checks if any filters are active
  bool get hasActiveFilters {
    return minPrice > 500 ||
        maxPrice < 5000 ||
        selectedContinent != null ||
        selectedCountry != null ||
        selectedDuration != null ||
        selectedCategories.isNotEmpty ||
        selectedServices.isNotEmpty;
  }
}
