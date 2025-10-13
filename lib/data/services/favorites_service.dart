import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

// Service to manage favorite packages using localStorage (SharedPreferences)
class FavoritesService {
  static const String _favoritesKey = 'favorite_packages';

  // Cache the SharedPreferences instance for better performance
  static SharedPreferences? _prefsInstance;

  // Get SharedPreferences instance with caching
  Future<SharedPreferences> _getPrefs() async {
    _prefsInstance ??= await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  // Add a package to favorites
  Future<void> addFavorite(String packageTitle) async {
    try {
      final prefs = await _getPrefs();
      final favorites = await getFavorites();

      if (!favorites.contains(packageTitle)) {
        favorites.add(packageTitle);
        await prefs.setStringList(_favoritesKey, favorites);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding favorite: $e');
      }
      rethrow;
    }
  }

  // Remove a package from favorites
  Future<void> removeFavorite(String packageTitle) async {
    try {
      final prefs = await _getPrefs();
      final favorites = await getFavorites();

      favorites.remove(packageTitle);
      await prefs.setStringList(_favoritesKey, favorites);
    } catch (e) {
      if (kDebugMode) {
        print('Error removing favorite: $e');
      }
      rethrow;
    }
  }

  // Get all favorite package titles
  Future<List<String>> getFavorites() async {
    try {
      final prefs = await _getPrefs();
      return prefs.getStringList(_favoritesKey) ?? [];
    } catch (e) {
      if (kDebugMode) {
        print('Error getting favorites: $e');
      }
      return [];
    }
  }

  // Check if a package is in favorites
  Future<bool> isFavorite(String packageTitle) async {
    try {
      final favorites = await getFavorites();
      return favorites.contains(packageTitle);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking favorite: $e');
      }
      return false;
    }
  }

  // Get number of favorites
  Future<int> getFavoritesCount() async {
    try {
      final favorites = await getFavorites();
      return favorites.length;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting favorites count: $e');
      }
      return 0;
    }
  }

  // Clear all favorites
  Future<void> clearFavorites() async {
    try {
      final prefs = await _getPrefs();
      await prefs.remove(_favoritesKey);
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing favorites: $e');
      }
      rethrow;
    }
  }

  // Toggle favorite status
  Future<bool> toggleFavorite(String packageTitle) async {
    try {
      final isFav = await isFavorite(packageTitle);

      if (isFav) {
        await removeFavorite(packageTitle);
        return false;
      } else {
        await addFavorite(packageTitle);
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error toggling favorite: $e');
      }
      rethrow;
    }
  }
}
