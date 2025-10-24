import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:by_lety_travels/presentation/providers/favorites_provider.dart';
import 'package:by_lety_travels/utils/responsive_utils.dart';
import 'package:by_lety_travels/presentation/widgets/components/responsive_app_bar.dart';
import 'package:by_lety_travels/presentation/widgets/components/mobile_menu_drawer.dart';
import 'package:by_lety_travels/presentation/widgets/components/mobile_bottom_nav_bar.dart';

/// Responsive Layout Wrapper for the app
/// Handles different layouts for mobile, tablet, and desktop
class ResponsiveLayout extends StatefulWidget {
  final Widget child;
  final bool showAppBar;
  final bool showBottomNav;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.showAppBar = true,
    this.showBottomNav = true,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentBottomNavIndex = 0;

  // Section keys for navigation
  final GlobalKey _heroSectionKey = GlobalKey();
  final GlobalKey _packagesSectionKey = GlobalKey();
  final GlobalKey _favoritesSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleMenuPressed() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });

    switch (index) {
      case 0: // Inicio
        _scrollToSection(_heroSectionKey);
        break;
      case 1: // Paquetes
        _scrollToSection(_packagesSectionKey);
        break;
      case 2: // Favoritos
        _scrollToSection(_favoritesSectionKey);
        break;
      case 3: // Perfil
        // Navigate to profile or show dialog
        _showProfileDialog();
        break;
    }
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Perfil'),
            content: const Text(
              'Funcionalidad de perfil próximamente.\nPor ahora puedes explorar nuestros paquetes y añadir favoritos.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,

      // Responsive App Bar
      appBar:
          widget.showAppBar
              ? ResponsiveAppBar(
                onMenuPressed: isMobile ? _handleMenuPressed : null,
                onHomePressed: () => _scrollToSection(_heroSectionKey),
                onPackagesPressed: () => _scrollToSection(_packagesSectionKey),
                onFavoritesPressed:
                    () => _scrollToSection(_favoritesSectionKey),
                onContactPressed: () => _scrollToSection(_contactSectionKey),
                favoritesCount: favoritesProvider.favoritesCount,
              )
              : null,

      // Mobile Drawer Menu
      drawer:
          isMobile
              ? MobileMenuDrawer(
                onHomePressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_heroSectionKey);
                },
                onPackagesPressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_packagesSectionKey);
                },
                onFavoritesPressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_favoritesSectionKey);
                },
                onContactPressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_contactSectionKey);
                },
              )
              : null,

      // Main Content
      body: widget.child,

      // Bottom Navigation for Mobile
      bottomNavigationBar:
          (isMobile && widget.showBottomNav)
              ? MobileBottomNavBar(
                currentIndex: _currentBottomNavIndex,
                onTap: _handleBottomNavTap,
              )
              : null,
    );
  }
}

/// Alternative Floating Bottom Nav version
class ResponsiveLayoutFloating extends StatefulWidget {
  final Widget child;
  final bool showAppBar;
  final bool showBottomNav;

  const ResponsiveLayoutFloating({
    super.key,
    required this.child,
    this.showAppBar = true,
    this.showBottomNav = true,
  });

  @override
  State<ResponsiveLayoutFloating> createState() =>
      _ResponsiveLayoutFloatingState();
}

class _ResponsiveLayoutFloatingState extends State<ResponsiveLayoutFloating> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentBottomNavIndex = 0;

  // Section keys for navigation (if needed in the future)
  final GlobalKey _heroSectionKey = GlobalKey();
  final GlobalKey _packagesSectionKey = GlobalKey();
  final GlobalKey _favoritesSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true, // For floating bottom nav

      appBar:
          widget.showAppBar
              ? ResponsiveAppBar(
                onMenuPressed:
                    isMobile
                        ? () => _scaffoldKey.currentState?.openDrawer()
                        : null,
                onHomePressed: () => _scrollToSection(_heroSectionKey),
                onPackagesPressed: () => _scrollToSection(_packagesSectionKey),
                onFavoritesPressed:
                    () => _scrollToSection(_favoritesSectionKey),
                onContactPressed: () => _scrollToSection(_contactSectionKey),
                favoritesCount: favoritesProvider.favoritesCount,
              )
              : null,

      drawer:
          isMobile
              ? MobileMenuDrawer(
                onHomePressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_heroSectionKey);
                },
                onPackagesPressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_packagesSectionKey);
                },
                onFavoritesPressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_favoritesSectionKey);
                },
                onContactPressed: () {
                  Navigator.of(context).pop();
                  _scrollToSection(_contactSectionKey);
                },
              )
              : null,

      body: widget.child,

      // Floating Bottom Navigation
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          (isMobile && widget.showBottomNav)
              ? Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: FloatingMobileBottomNavBar(
                  currentIndex: _currentBottomNavIndex,
                  onTap: _handleBottomNavTap,
                ),
              )
              : null,
    );
  }
}
