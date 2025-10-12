import 'package:shared_preferences/shared_preferences.dart';

// Service to manage favorite packages using localStorage (SharedPreferences)
class FavoritesService {
  static const String _favoritesKey = 'favorite_packages';

  // Add a package to favorites
  Future<void> addFavorite(String packageTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (!favorites.contains(packageTitle)) {
      favorites.add(packageTitle);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  // Remove a package from favorites
  Future<void> removeFavorite(String packageTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    favorites.remove(packageTitle);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  // Get all favorite package titles
  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  // Check if a package is in favorites
  Future<bool> isFavorite(String packageTitle) async {
    final favorites = await getFavorites();
    return favorites.contains(packageTitle);
  }

  // Get number of favorites
  Future<int> getFavoritesCount() async {
    final favorites = await getFavorites();
    return favorites.length;
  }

  // Clear all favorites
  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }

  // Toggle favorite status
  Future<bool> toggleFavorite(String packageTitle) async {
    final isFav = await isFavorite(packageTitle);

    if (isFav) {
      await removeFavorite(packageTitle);
      return false;
    } else {
      await addFavorite(packageTitle);
      return true;
    }
  }
}
