import 'package:flutter/material.dart';

/// Mobile Hamburger Menu Drawer
class MobileMenuDrawer extends StatelessWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onPackagesPressed;
  final VoidCallback? onFavoritesPressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onContactPressed;

  const MobileMenuDrawer({
    super.key,
    this.onHomePressed,
    this.onPackagesPressed,
    this.onFavoritesPressed,
    this.onAboutPressed,
    this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF072A47), Color(0xFF0A3D5F)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.flight_takeoff,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'By Lety Travels',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tu aventura comienza aquí',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white24, thickness: 1),
              const SizedBox(height: 8),

              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.home_outlined,
                      title: 'Inicio',
                      onTap: () {
                        Navigator.of(context).pop();
                        onHomePressed?.call();
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.card_travel_outlined,
                      title: 'Paquetes',
                      onTap: () {
                        Navigator.of(context).pop();
                        onPackagesPressed?.call();
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.favorite_border,
                      title: 'Favoritos',
                      onTap: () {
                        Navigator.of(context).pop();
                        onFavoritesPressed?.call();
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.info_outline,
                      title: 'Sobre Nosotros',
                      onTap: () {
                        Navigator.of(context).pop();
                        onAboutPressed?.call();
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.contact_mail_outlined,
                      title: 'Contacto',
                      onTap: () {
                        Navigator.of(context).pop();
                        onContactPressed?.call();
                      },
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 16),
                    _buildMenuItem(
                      context,
                      icon: Icons.policy_outlined,
                      title: 'Política de Privacidad',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/privacy-policy');
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.description_outlined,
                      title: 'Términos y Condiciones',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/terms-conditions');
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.assignment_return_outlined,
                      title: 'Política de Reembolso',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/refund-policy');
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.cookie_outlined,
                      title: 'Política de Cookies',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/cookie-policy');
                      },
                    ),
                  ],
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📧 byletytravels.oficial@gmail.com',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '📞 +54 9 3884102859',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildSocialIcon(Icons.facebook, () {}),
                        const SizedBox(width: 12),
                        _buildSocialIcon(Icons.camera_alt, () {}),
                        const SizedBox(width: 12),
                        _buildSocialIcon(Icons.chat, () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      hoverColor: Colors.white10,
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
