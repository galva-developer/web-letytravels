import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';
import '../travel_package_card.dart';

class MyFavoritesSection extends StatelessWidget {
  final GlobalKey? sectionKey;

  const MyFavoritesSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        return Container(
          key: sectionKey,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF072A47).withOpacity(0.02), Colors.white],
            ),
          ),
          child: _buildContent(context, favoritesProvider),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    FavoritesProvider favoritesProvider,
  ) {
    final favoritePackages = favoritesProvider.getFavoritePackages();
    final isLoading = favoritesProvider.isLoading;

    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF072A47)),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        _buildHeader(context, favoritePackages.length),
        const SizedBox(height: 40),

        // Comparison Button (centered, visible when can compare)
        if (favoritesProvider.canCompare)
          _buildComparisonButton(context, favoritesProvider),

        if (favoritesProvider.canCompare) const SizedBox(height: 24),

        // Content: Empty State or Favorites Grid
        if (favoritePackages.isEmpty)
          _buildEmptyState(context)
        else
          _buildFavoritesGrid(context, favoritePackages, favoritesProvider),
      ],
    );
  }

  Widget _buildComparisonButton(
    BuildContext context,
    FavoritesProvider favoritesProvider,
  ) {
    final count = favoritesProvider.selectedComparisonCount;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ElevatedButton.icon(
          onPressed: () => _showComparisonModal(context, favoritesProvider),
          icon: const Icon(Icons.compare_arrows, size: 24),
          label: Text(
            'Comparar $count ${count == 2 ? 'Paquetes' : 'Paquetes'}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFDC00),
            foregroundColor: const Color(0xFF072A47),
            elevation: 4,
            shadowColor: const Color(0xFFFFDC00).withOpacity(0.4),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.favorite, color: Colors.red[400], size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mis Favoritos',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF072A47),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count > 0
                        ? '$count ${count == 1 ? 'paquete guardado' : 'paquetes guardados'}'
                        : 'Aún no tienes favoritos',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (count > 0)
              OutlinedButton.icon(
                onPressed: () => _showClearConfirmation(context),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Limpiar Todo'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red[400],
                  side: BorderSide(color: Colors.red[300]!),
                ),
              ),
          ],
        ),
        if (count > 0) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDC00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFFFDC00).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: const Color(0xFF072A47),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tus favoritos se guardan localmente en tu navegador. Puedes comparar hasta 3 paquetes a la vez.',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF072A47).withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
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
              child: Icon(
                Icons.favorite_border,
                size: 60,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '¡Aún no tienes favoritos!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF072A47),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Empieza a agregar paquetes turísticos a tu lista de deseos haciendo clic en el ícono de corazón.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _scrollToPackages(context),
              icon: const Icon(Icons.explore),
              label: const Text('Explorar Paquetes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF072A47),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesGrid(
    BuildContext context,
    List<dynamic> favoritePackages,
    FavoritesProvider favoritesProvider,
  ) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return LayoutBuilder(
      builder: (context, constraints) {
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
          itemCount: favoritePackages.length,
          itemBuilder: (context, index) {
            final package = favoritePackages[index];
            final isSelected = favoritesProvider.isSelectedForComparison(
              package.title,
            );
            final isMaxReached = favoritesProvider.isMaxComparisonReached;
            final canSelect = !isMaxReached || isSelected;

            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: minCardWidth,
                maxWidth: maxCardWidth,
              ),
              child: Stack(
                children: [
                  TravelPackageCard(
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
                    originalPrice: package.originalPrice,
                    discountPercentage: package.discountPercentage,
                    isNew: package.isNew,
                    isPopular: package.isPopular,
                    hasLimitedSeats: package.hasLimitedSeats,
                    availableSeats: package.availableSeats,
                    services: package.services,
                    onViewDetailsPressed: () {
                      // Modal will be opened by the card itself
                    },
                  ),
                  // Comparison checkbox overlay - centered at top
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap:
                              canSelect
                                  ? () => favoritesProvider
                                      .toggleComparisonSelection(package.title)
                                  : null,
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? const Color(0xFF072A47)
                                        : Colors.grey.withOpacity(0.3),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged:
                                      canSelect
                                          ? (value) => favoritesProvider
                                              .toggleComparisonSelection(
                                                package.title,
                                              )
                                          : null,
                                  activeColor: const Color(0xFF072A47),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Text(
                                  'Comparar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        canSelect
                                            ? const Color(0xFF072A47)
                                            : Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _scrollToPackages(BuildContext context) {
    // This will be handled by the parent HomePage
    // For now, just pop the favorites section view if it's in a modal
    // or the user can manually scroll up
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Desplázate hacia arriba para ver todos los paquetes'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF072A47),
      ),
    );
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange[700]),
              const SizedBox(width: 12),
              const Text('Confirmar Limpieza'),
            ],
          ),
          content: const Text(
            '¿Estás seguro de que deseas eliminar todos tus favoritos? Esta acción no se puede deshacer.',
            style: TextStyle(height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<FavoritesProvider>(
                  context,
                  listen: false,
                ).clearAllFavorites();
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Todos los favoritos han sido eliminados'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar Todo'),
            ),
          ],
        );
      },
    );
  }

  void _showComparisonModal(
    BuildContext context,
    FavoritesProvider favoritesProvider,
  ) {
    final selectedPackages =
        favoritesProvider.getSelectedPackagesForComparison();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF072A47),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.compare_arrows,
                        color: Color(0xFFFFDC00),
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Comparación de Paquetes',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Comparison Table
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: _buildComparisonTable(selectedPackages),
                  ),
                ),
                // Footer
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          favoritesProvider.clearComparisonSelection();
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text('Limpiar Selección'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF072A47),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildComparisonTable(List<dynamic> packages) {
    return Table(
      border: TableBorder.all(color: Colors.grey[300]!, width: 1),
      columnWidths: {
        0: const FixedColumnWidth(150),
        for (int i = 1; i <= packages.length; i++) i: const FlexColumnWidth(1),
      },
      children: [
        // Header row with package titles
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[100]),
          children: [
            _buildTableCell('', isHeader: true),
            for (var package in packages)
              _buildTableCell(
                package.title,
                isHeader: true,
                fontWeight: FontWeight.bold,
              ),
          ],
        ),
        // Price row
        _buildComparisonRow(
          'Precio',
          packages.map<String>((p) => p.price as String).toList(),
          Colors.green[50],
        ),
        // Original Price (if discount)
        if (packages.any((p) => p.hasDiscount))
          _buildComparisonRow(
            'Precio Original',
            packages
                .map<String>((p) => (p.originalPrice as String?) ?? '-')
                .toList(),
            null,
          ),
        // Discount
        if (packages.any((p) => p.hasDiscount))
          _buildComparisonRow(
            'Descuento',
            packages
                .map<String>(
                  (p) =>
                      p.discountPercentage != null
                          ? '${p.discountPercentage}%'
                          : '-',
                )
                .toList(),
            Colors.red[50],
          ),
        // Duration
        _buildComparisonRow(
          'Duración',
          packages.map<String>((p) => p.duration as String).toList(),
          null,
        ),
        // Location
        _buildComparisonRow(
          'Destino',
          packages.map<String>((p) => p.location as String).toList(),
          null,
        ),
        // Hotel Rating
        _buildComparisonRow(
          'Hotel',
          packages.map<String>((p) => '⭐ ${p.hotelRating}').toList(),
          Colors.amber[50],
        ),
        // Flights Included
        _buildComparisonRow(
          'Vuelos',
          packages
              .map<String>((p) => p.flightsIncluded ? '✅ Incluidos' : '❌ No')
              .toList(),
          null,
        ),
        // Guided Tours
        _buildComparisonRow(
          'Tours Guiados',
          packages
              .map<String>((p) => p.guidedTours ? '✅ Incluidos' : '❌ No')
              .toList(),
          null,
        ),
        // Services
        _buildComparisonRow(
          'Servicios',
          packages
              .map<String>((p) => '${p.services.length} incluidos')
              .toList(),
          Colors.blue[50],
        ),
      ],
    );
  }

  TableRow _buildComparisonRow(
    String label,
    List<String> values,
    Color? backgroundColor,
  ) {
    return TableRow(
      decoration: BoxDecoration(color: backgroundColor),
      children: [
        _buildTableCell(label, fontWeight: FontWeight.w600),
        for (var value in values) _buildTableCell(value),
      ],
    );
  }

  Widget _buildTableCell(
    String text, {
    bool isHeader = false,
    FontWeight? fontWeight,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 14 : 13,
          fontWeight:
              fontWeight ?? (isHeader ? FontWeight.bold : FontWeight.normal),
          color: isHeader ? const Color(0xFF072A47) : Colors.black87,
        ),
        textAlign: isHeader ? TextAlign.center : TextAlign.left,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
