import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:by_lety_travels/data/models/package_travel.dart'; // Import the model
import 'package:by_lety_travels/presentation/widgets/sections/hero_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/filterable_packages_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/my_favorites_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/contact_footer_section.dart';
import 'package:by_lety_travels/data/repositories/sample_packages.dart';
import 'package:by_lety_travels/presentation/providers/favorites_provider.dart';
import 'package:by_lety_travels/presentation/pages/search_results_page.dart';
import 'package:by_lety_travels/presentation/widgets/floating_whatsapp_button.dart';
import 'package:by_lety_travels/presentation/widgets/social_media_links.dart';
import 'package:by_lety_travels/presentation/widgets/instagram_feed.dart';

class HomePage extends StatefulWidget {
  // Changed to StatefulWidget
  const HomePage({super.key}); // Added const constructor

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Created State class
  // Keys for scrolling to sections
  final GlobalKey _heroSectionKey = GlobalKey();
  final GlobalKey _popularDestinationsSectionKey =
      GlobalKey(); // Renamed from _packagesSectionKey
  final GlobalKey _favoritesSectionKey =
      GlobalKey(); // Key for MyFavoritesSection
  final GlobalKey _contactSectionKey = GlobalKey();

  // Hover states for AppBar buttons
  bool _isInicioHovered = false;
  bool _isPaquetesHovered = false;
  bool _isContactoHovered = false;

  // Function to scroll to a specific section
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // List of travel packages to display - this could also be fetched from a BLoC/repository
  final List<PackageTravel> popularDestinations = const [
    PackageTravel(
      title: 'París Encantador',
      price: '\$1500',
      priceValue: 1500,
      location: 'París, Francia',
      continent: 'Europa',
      country: 'Francia',
      description:
          'Experimenta la ciudad de las luces, monumentos icónicos y ambiente romántico.',
      duration: '5 Días / 4 Noches',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Romántico',
      services: ['Vuelos', 'Tours Guiados', 'Comidas Incluidas'],
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    PackageTravel(
      title: 'Aventura en la Antigua Roma',
      price: '\$1350',
      priceValue: 1350,
      location: 'Roma, Italia',
      continent: 'Europa',
      country: 'Italia',
      description:
          'Explora ruinas históricas, arte magnífico y deliciosa cocina italiana.',
      duration: '6 Días / 5 Noches',
      durationDays: 6,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Aventura',
      services: ['Vuelos', 'Tours Guiados'],
      imageUrl:
          'https://images.unsplash.com/photo-1529260830199-42c24126f198?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    PackageTravel(
      title: 'Viaje Místico a Kioto',
      price: '\$1800',
      priceValue: 1800,
      location: 'Kioto, Japón',
      continent: 'Asia',
      country: 'Japón',
      description:
          'Descubre templos serenos, hermosos jardines y cultura japonesa tradicional.',
      duration: '7 Días / 6 Noches',
      durationDays: 7,
      flightsIncluded: false,
      hotelRating: '5 Estrellas',
      guidedTours: true,
      category: 'Lujo',
      services: ['Hotel 5★', 'Tours Guiados', 'Comidas Incluidas'],
      imageUrl:
          'https://images.unsplash.com/photo-1545569341-9eb8b30979d9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  // Helper method para construir botones de navegación
  Widget _buildNavButton(
    String label,
    bool isHovered,
    VoidCallback onPressed,
    Function(bool) onHover,
  ) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor:
              isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isHovered ? const Color(0xFFFFDC00) : Colors.white,
            fontFamily: 'LetyTravelsFont',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Permite que el contenido se extienda detrás del AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF072A47).withOpacity(0.95),
                const Color(0xFF072A47).withOpacity(0.95),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDC00).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/icons8-airport-50.png',
                        width: 32,
                        height: 32,
                        color: const Color(0xFFFFDC00),
                      ),
                    ),
                    const SizedBox(width: 12),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'LetyTravelsFont',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: 'ByLety'),
                          TextSpan(
                            text: 'Travels',
                            style: TextStyle(color: Color(0xFFFFDC00)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 24),

                // Navigation buttons
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildNavButton(
                        'Inicio',
                        _isInicioHovered,
                        () {
                          _scrollToSection(_heroSectionKey);
                        },
                        (hovering) {
                          setState(() => _isInicioHovered = hovering);
                        },
                      ),
                      _buildNavButton(
                        'Paquetes',
                        _isPaquetesHovered,
                        () {
                          _scrollToSection(_popularDestinationsSectionKey);
                        },
                        (hovering) {
                          setState(() => _isPaquetesHovered = hovering);
                        },
                      ),
                      _buildNavButton(
                        'Contacto',
                        _isContactoHovered,
                        () {
                          _scrollToSection(_contactSectionKey);
                        },
                        (hovering) {
                          setState(() => _isContactoHovered = hovering);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                // Right side actions
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Social media icons
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const SocialMediaLinksCompact(),
                    ),
                    const SizedBox(width: 12),
                    // Search button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchResultsPage(),
                            ),
                          );
                        },
                        tooltip: 'Buscar',
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Favorites badge
                    Consumer<FavoritesProvider>(
                      builder: (context, favoritesProvider, child) {
                        final count = favoritesProvider.favoritesCount;

                        return Stack(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // TODO: Navigate to favorites section
                                _scrollToSection(_favoritesSectionKey);
                              },
                              tooltip: 'Mis Favoritos',
                            ),
                            if (count > 0)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Text(
                                    count > 99 ? '99+' : count.toString(),
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
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            // Keep SingleChildScrollView for overall page scroll
            child: Column(
              children: <Widget>[
                HeroSection(
                  sectionKey: _heroSectionKey,
                  onExploreDestinations:
                      () => _scrollToSection(_popularDestinationsSectionKey),
                ),
                // New Filterable Packages Section with Advanced Filters
                FilterablePackagesSection(
                  sectionKey: _popularDestinationsSectionKey,
                  allPackages: SamplePackages.allPackages,
                ),
                MyFavoritesSection(sectionKey: _favoritesSectionKey),

                // Instagram Feed Section
                const InstagramFeed(),

                ContactFooterSection(sectionKey: _contactSectionKey),
              ],
            ),
          ),
          // Botón flotante de WhatsApp
          const FloatingWhatsAppButton(),
        ],
      ),
    );
  }
}
