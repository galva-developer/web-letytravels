import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/package_filters.dart';

/// Advanced filters widget for travel packages
/// Allows users to filter by price, destination, duration, category, and services
class PackageFiltersWidget extends StatefulWidget {
  final PackageFilters initialFilters;
  final Function(PackageFilters) onFiltersChanged;
  final VoidCallback onClearFilters;

  const PackageFiltersWidget({
    super.key,
    required this.initialFilters,
    required this.onFiltersChanged,
    required this.onClearFilters,
  });

  @override
  State<PackageFiltersWidget> createState() => _PackageFiltersWidgetState();
}

class _PackageFiltersWidgetState extends State<PackageFiltersWidget> {
  late PackageFilters _currentFilters;
  late RangeValues _priceRange;

  // Available options for filters
  final List<String> _continents = [
    'Todos',
    'Europa',
    'Asia',
    'América',
    'África',
    'Oceanía',
  ];

  final Map<String, List<String>> _countriesByContinent = {
    'Europa': ['Francia', 'Italia', 'España', 'Alemania', 'Reino Unido'],
    'Asia': ['Japón', 'Tailandia', 'China', 'India', 'Indonesia'],
    'América': ['EE.UU.', 'Brasil', 'Argentina', 'México', 'Canadá'],
    'África': ['Egipto', 'Sudáfrica', 'Marruecos', 'Kenia', 'Tanzania'],
    'Oceanía': ['Australia', 'Nueva Zelanda', 'Fiji', 'Polinesia Francesa'],
  };

  final List<String> _durations = ['Todos', '3-5 días', '6-8 días', '9+ días'];

  final List<String> _categories = [
    'Aventura',
    'Romántico',
    'Familiar',
    'Lujo',
  ];

  final List<String> _services = [
    'Vuelos',
    'Hotel 5★',
    'Tours Guiados',
    'Comidas Incluidas',
  ];

  @override
  void initState() {
    super.initState();
    _currentFilters = widget.initialFilters;
    _priceRange = RangeValues(
      _currentFilters.minPrice,
      _currentFilters.maxPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF072A47),
                ),
              ),
              if (_currentFilters.hasActiveFilters)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _currentFilters = _currentFilters.reset();
                      _priceRange = RangeValues(500, 5000);
                    });
                    widget.onClearFilters();
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Limpiar Todo'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
            ],
          ),
          const Divider(height: 24),

          // Price Range Slider
          _buildPriceFilter(),
          const SizedBox(height: 24),

          // Destination Filter
          _buildDestinationFilter(isMobile),
          const SizedBox(height: 24),

          // Duration Filter
          _buildDurationFilter(isMobile),
          const SizedBox(height: 24),

          // Category Filter
          _buildCategoryFilter(),
          const SizedBox(height: 24),

          // Services Filter
          _buildServicesFilter(),
          const SizedBox(height: 24),

          // Apply Filters Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                widget.onFiltersChanged(_currentFilters);
              },
              icon: const Icon(Icons.filter_list),
              label: const Text('Aplicar Filtros'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF072A47),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build price range filter with slider
  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.attach_money, color: Color(0xFF072A47), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Rango de Precio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF072A47),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: _priceRange,
          min: 500,
          max: 5000,
          divisions: 45,
          activeColor: const Color(0xFFFFDC00),
          inactiveColor: const Color(0xFFFFDC00).withOpacity(0.3),
          labels: RangeLabels(
            '\$${_priceRange.start.round()}',
            '\$${_priceRange.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
              _currentFilters = _currentFilters.copyWith(
                minPrice: values.start,
                maxPrice: values.end,
              );
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_priceRange.start.round()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF072A47),
                ),
              ),
              Text(
                '\$${_priceRange.end.round()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF072A47),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build destination filter with continent and country dropdowns
  Widget _buildDestinationFilter(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF072A47), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Destino',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF072A47),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Continent dropdown
        DropdownButtonFormField<String>(
          value: _currentFilters.selectedContinent ?? 'Todos',
          decoration: InputDecoration(
            labelText: 'Continente',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          items:
              _continents.map((continent) {
                return DropdownMenuItem(
                  value: continent,
                  child: Text(continent),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              if (value == 'Todos') {
                _currentFilters = _currentFilters.copyWith(
                  clearContinent: true,
                  clearCountry: true,
                );
              } else {
                _currentFilters = _currentFilters.copyWith(
                  selectedContinent: value,
                  clearCountry: true,
                );
              }
            });
          },
        ),
        if (_currentFilters.selectedContinent != null &&
            _currentFilters.selectedContinent != 'All') ...[
          const SizedBox(height: 12),
          // Country dropdown (only shown when continent is selected)
          DropdownButtonFormField<String>(
            value: _currentFilters.selectedCountry,
            decoration: InputDecoration(
              labelText: 'País',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Todos los Países'),
              ),
              ...(_countriesByContinent[_currentFilters.selectedContinent!] ??
                      [])
                  .map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }),
            ],
            onChanged: (value) {
              setState(() {
                _currentFilters = _currentFilters.copyWith(
                  selectedCountry: value,
                );
              });
            },
          ),
        ],
      ],
    );
  }

  /// Build duration filter dropdown
  Widget _buildDurationFilter(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.schedule, color: Color(0xFF072A47), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Duración',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF072A47),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _currentFilters.selectedDuration ?? 'Todos',
          decoration: InputDecoration(
            labelText: 'Duración del Viaje',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          items:
              _durations.map((duration) {
                return DropdownMenuItem(value: duration, child: Text(duration));
              }).toList(),
          onChanged: (value) {
            setState(() {
              if (value == 'Todos') {
                _currentFilters = _currentFilters.copyWith(clearDuration: true);
              } else {
                _currentFilters = _currentFilters.copyWith(
                  selectedDuration: value,
                );
              }
            });
          },
        ),
      ],
    );
  }

  /// Build category filter with checkboxes
  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.category, color: Color(0xFF072A47), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Categoría',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF072A47),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _categories.map((category) {
                final isSelected = _currentFilters.selectedCategories.contains(
                  category,
                );
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      final newCategories = Set<String>.from(
                        _currentFilters.selectedCategories,
                      );
                      if (selected) {
                        newCategories.add(category);
                      } else {
                        newCategories.remove(category);
                      }
                      _currentFilters = _currentFilters.copyWith(
                        selectedCategories: newCategories,
                      );
                    });
                  },
                  selectedColor: const Color(0xFFFFDC00),
                  checkmarkColor: const Color(0xFF072A47),
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color:
                        isSelected ? const Color(0xFF072A47) : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  /// Build services filter with checkboxes
  Widget _buildServicesFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.room_service, color: Color(0xFF072A47), size: 20),
            const SizedBox(width: 8),
            const Text(
              'Servicios Incluidos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF072A47),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _services.map((service) {
                final isSelected = _currentFilters.selectedServices.contains(
                  service,
                );
                return FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getServiceIcon(service),
                        size: 16,
                        color:
                            isSelected
                                ? const Color(0xFF072A47)
                                : Colors.black54,
                      ),
                      const SizedBox(width: 6),
                      Text(service),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      final newServices = Set<String>.from(
                        _currentFilters.selectedServices,
                      );
                      if (selected) {
                        newServices.add(service);
                      } else {
                        newServices.remove(service);
                      }
                      _currentFilters = _currentFilters.copyWith(
                        selectedServices: newServices,
                      );
                    });
                  },
                  selectedColor: const Color(0xFFFFDC00),
                  checkmarkColor: const Color(0xFF072A47),
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color:
                        isSelected ? const Color(0xFF072A47) : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  /// Get icon for service type
  IconData _getServiceIcon(String service) {
    switch (service) {
      case 'Vuelos':
        return Icons.flight;
      case 'Hotel 5★':
        return Icons.hotel;
      case 'Tours Guiados':
        return Icons.tour;
      case 'Comidas Incluidas':
        return Icons.restaurant;
      default:
        return Icons.check_circle;
    }
  }
}
