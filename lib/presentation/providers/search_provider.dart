import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/data/repositories/sample_packages.dart';

/// Provider to manage search state and functionality
class SearchProvider with ChangeNotifier {
  String _searchQuery = '';
  List<PackageTravel> _searchResults = [];
  List<String> _searchHistory = [];
  bool _isSearching = false;
  static const String _historyKey = 'search_history';
  static const int _maxHistoryItems = 10;

  // Getters
  String get searchQuery => _searchQuery;
  List<PackageTravel> get searchResults => _searchResults;
  List<String> get searchHistory => _searchHistory;
  bool get isSearching => _isSearching;
  bool get hasResults => _searchResults.isNotEmpty;
  bool get hasQuery => _searchQuery.trim().isNotEmpty;

  SearchProvider() {
    _loadSearchHistory();
  }

  /// Load search history from SharedPreferences
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey) ?? [];
    _searchHistory = history;
    notifyListeners();
  }

  /// Update search query and perform search
  void updateQuery(String query) {
    _searchQuery = query;
    _isSearching = true;
    notifyListeners();

    if (query.trim().isEmpty) {
      _searchResults.clear();
      _isSearching = false;
      notifyListeners();
      return;
    }

    // Perform search
    _performSearch(query);
  }

  /// Perform search across all packages
  void _performSearch(String query) {
    final lowercaseQuery = query.toLowerCase().trim();
    final allPackages = SamplePackages.allPackages;

    _searchResults =
        allPackages.where((package) {
          final title = package.title.toLowerCase();
          final location = package.location.toLowerCase();
          final description = package.description.toLowerCase();

          // Search in title, location, description
          return title.contains(lowercaseQuery) ||
              location.contains(lowercaseQuery) ||
              description.contains(lowercaseQuery);
        }).toList();

    // Sort by relevance (title matches first, then location, then description)
    _searchResults.sort((a, b) {
      final aTitle = a.title.toLowerCase();
      final bTitle = b.title.toLowerCase();
      final aLocation = a.location.toLowerCase();
      final bLocation = b.location.toLowerCase();

      // Title exact match
      if (aTitle.contains(lowercaseQuery) && !bTitle.contains(lowercaseQuery)) {
        return -1;
      }
      if (!aTitle.contains(lowercaseQuery) && bTitle.contains(lowercaseQuery)) {
        return 1;
      }

      // Location match
      if (aLocation.contains(lowercaseQuery) &&
          !bLocation.contains(lowercaseQuery)) {
        return -1;
      }
      if (!aLocation.contains(lowercaseQuery) &&
          bLocation.contains(lowercaseQuery)) {
        return 1;
      }

      return 0;
    });

    _isSearching = false;
    notifyListeners();
  }

  /// Get search suggestions based on current query
  List<String> getSuggestions(String query) {
    if (query.trim().isEmpty) {
      return _searchHistory.take(5).toList();
    }

    final lowercaseQuery = query.toLowerCase().trim();
    final allPackages = SamplePackages.allPackages;
    final suggestions = <String>{};

    for (var package in allPackages) {
      // Add matching titles
      if (package.title.toLowerCase().contains(lowercaseQuery)) {
        suggestions.add(package.title);
      }

      // Add matching locations
      if (package.location.toLowerCase().contains(lowercaseQuery)) {
        suggestions.add(package.location);
      }

      // Stop at 8 suggestions
      if (suggestions.length >= 8) break;
    }

    return suggestions.toList();
  }

  /// Execute search and add to history
  Future<void> executeSearch(String query) async {
    if (query.trim().isEmpty) return;

    updateQuery(query);
    await _addToHistory(query);
  }

  /// Add search query to history
  Future<void> _addToHistory(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;

    // Remove if already exists
    _searchHistory.remove(trimmedQuery);

    // Add to beginning
    _searchHistory.insert(0, trimmedQuery);

    // Keep only max items
    if (_searchHistory.length > _maxHistoryItems) {
      _searchHistory = _searchHistory.take(_maxHistoryItems).toList();
    }

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, _searchHistory);

    notifyListeners();
  }

  /// Clear search query and results
  void clearSearch() {
    _searchQuery = '';
    _searchResults.clear();
    _isSearching = false;
    notifyListeners();
  }

  /// Clear search history
  Future<void> clearHistory() async {
    _searchHistory.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    notifyListeners();
  }

  /// Remove specific item from history
  Future<void> removeFromHistory(String query) async {
    _searchHistory.remove(query);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, _searchHistory);
    notifyListeners();
  }
}
