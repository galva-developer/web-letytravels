import 'package:flutter/foundation.dart';
import 'package:by_lety_travels/data/services/favorites_service.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/data/repositories/sample_packages.dart';

// Provider to manage favorites state globally
class FavoritesProvider with ChangeNotifier {
  final FavoritesService _favoritesService = FavoritesService();
  List<String> _favoriteTitles = [];
  bool _isLoading = true;

  // Comparison state
  List<String> _selectedForComparison = [];
  static const int maxComparisonPackages = 3;

  List<String> get favoriteTitles => _favoriteTitles;
  int get favoritesCount => _favoriteTitles.length;
  bool get isLoading => _isLoading;

  // Comparison getters
  List<String> get selectedForComparison => _selectedForComparison;
  int get selectedComparisonCount => _selectedForComparison.length;
  bool get canCompare =>
      _selectedForComparison.length >= 2 &&
      _selectedForComparison.length <= maxComparisonPackages;
  bool get isMaxComparisonReached =>
      _selectedForComparison.length >= maxComparisonPackages;

  FavoritesProvider() {
    _loadFavorites();
  }

  // Load favorites from storage on initialization
  Future<void> _loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    _favoriteTitles = await _favoritesService.getFavorites();

    _isLoading = false;
    notifyListeners();
  }

  // Check if a package is favorite
  bool isFavorite(String packageTitle) {
    return _favoriteTitles.contains(packageTitle);
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String packageTitle) async {
    final isFav = isFavorite(packageTitle);

    if (isFav) {
      await _favoritesService.removeFavorite(packageTitle);
      _favoriteTitles.remove(packageTitle);
      // Also remove from comparison if it was selected
      removeFromComparison(packageTitle);
    } else {
      await _favoritesService.addFavorite(packageTitle);
      _favoriteTitles.add(packageTitle);
    }

    notifyListeners();
  }

  // Get favorite packages (full objects)
  List<PackageTravel> getFavoritePackages() {
    return SamplePackages.allPackages
        .where((package) => _favoriteTitles.contains(package.title))
        .toList();
  }

  // Clear all favorites
  Future<void> clearAllFavorites() async {
    await _favoritesService.clearFavorites();
    _favoriteTitles.clear();
    // Also clear comparison selections
    _selectedForComparison.clear();
    notifyListeners();
  }

  // Refresh favorites from storage
  Future<void> refreshFavorites() async {
    await _loadFavorites();
  }

  // ============= COMPARISON METHODS =============

  // Check if a package is selected for comparison
  bool isSelectedForComparison(String packageTitle) {
    return _selectedForComparison.contains(packageTitle);
  }

  // Toggle package selection for comparison
  void toggleComparisonSelection(String packageTitle) {
    if (_selectedForComparison.contains(packageTitle)) {
      _selectedForComparison.remove(packageTitle);
    } else {
      // Only add if not at max
      if (_selectedForComparison.length < maxComparisonPackages) {
        _selectedForComparison.add(packageTitle);
      }
    }
    notifyListeners();
  }

  // Clear all comparison selections
  void clearComparisonSelection() {
    _selectedForComparison.clear();
    notifyListeners();
  }

  // Get selected packages for comparison (full objects)
  List<PackageTravel> getSelectedPackagesForComparison() {
    return SamplePackages.allPackages
        .where((package) => _selectedForComparison.contains(package.title))
        .toList();
  }

  // Remove package from comparison (e.g., when removed from favorites)
  void removeFromComparison(String packageTitle) {
    if (_selectedForComparison.contains(packageTitle)) {
      _selectedForComparison.remove(packageTitle);
      notifyListeners();
    }
  }
}
