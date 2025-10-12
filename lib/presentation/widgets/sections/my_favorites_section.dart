import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';
import '../travel_package_card.dart';

class MyFavoritesSection extends StatelessWidget {
  final GlobalKey? sectionKey;

  const MyFavoritesSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
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
      child: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
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

              // Content: Empty State or Favorites Grid
              if (favoritePackages.isEmpty)
                _buildEmptyState(context)
              else
                _buildFavoritesGrid(
                  context,
                  favoritePackages,
                  favoritesProvider,
                ),
            ],
          );
        },
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
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        screenWidth > 1200
            ? 3
            : screenWidth > 768
            ? 2
            : 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.75,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: favoritePackages.length,
          itemBuilder: (context, index) {
            final package = favoritePackages[index];
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
}
