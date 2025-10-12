import 'package:flutter/foundation.dart';
import 'package:by_lety_travels/data/services/favorites_service.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/data/repositories/sample_packages.dart';

// Provider to manage favorites state globally
class FavoritesProvider with ChangeNotifier {
  final FavoritesService _favoritesService = FavoritesService();
  List<String> _favoriteTitles = [];
  bool _isLoading = true;

  List<String> get favoriteTitles => _favoriteTitles;
  int get favoritesCount => _favoriteTitles.length;
  bool get isLoading => _isLoading;

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
    notifyListeners();
  }

  // Refresh favorites from storage
  Future<void> refreshFavorites() async {
    await _loadFavorites();
  }
}
