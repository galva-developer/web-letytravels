import 'package:flutter/material.dart';
import 'package:by_lety_travels/utils/responsive_utils.dart';

/// Responsive App Bar that adapts to different screen sizes
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onHomePressed;
  final VoidCallback? onPackagesPressed;
  final VoidCallback? onFavoritesPressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onContactPressed;
  final int favoritesCount;

  const ResponsiveAppBar({
    super.key,
    this.onMenuPressed,
    this.onHomePressed,
    this.onPackagesPressed,
    this.onFavoritesPressed,
    this.onAboutPressed,
    this.onContactPressed,
    this.favoritesCount = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF072A47), Color(0xFF0A3D5F)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: ResponsiveUtils.getResponsiveHorizontalPadding(context),
          child:
              isMobile
                  ? _buildMobileAppBar(context)
                  : _buildDesktopAppBar(context),
        ),
      ),
    );
  }

  Widget _buildMobileAppBar(BuildContext context) {
    return Row(
      children: [
        // Hamburger Menu Button
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          onPressed: onMenuPressed,
        ),
        const SizedBox(width: 8),

        // Logo
        Expanded(
          child: Row(
            children: [
              const Icon(Icons.flight_takeoff, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'By Lety Travels',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        // Favorites Badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: onFavoritesPressed,
            ),
            if (favoritesCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    favoritesCount > 9 ? '9+' : '$favoritesCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopAppBar(BuildContext context) {
    return Row(
      children: [
        // Logo
        InkWell(
          onTap: onHomePressed,
          child: Row(
            children: [
              const Icon(Icons.flight_takeoff, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By Lety Travels',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tu aventura comienza aquí',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Spacer(),

        // Navigation Menu
        _buildNavButton('Inicio', onHomePressed),
        const SizedBox(width: 8),
        _buildNavButton('Paquetes', onPackagesPressed),
        const SizedBox(width: 8),
        _buildNavButton('Sobre Nosotros', onAboutPressed),
        const SizedBox(width: 8),
        _buildNavButton('Contacto', onContactPressed),
        const SizedBox(width: 16),

        // Favorites with Badge
        Stack(
          children: [
            _buildNavButton(
              'Favoritos',
              onFavoritesPressed,
              icon: Icons.favorite_border,
            ),
            if (favoritesCount > 0)
              Positioned(
                right: 8,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    favoritesCount > 9 ? '9+' : '$favoritesCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavButton(
    String text,
    VoidCallback? onPressed, {
    IconData? icon,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 6)],
          Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
