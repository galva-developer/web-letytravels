import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:by_lety_travels/data/models/package_travel.dart'; // Import the model
import 'package:by_lety_travels/presentation/widgets/sections/hero_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/filterable_packages_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/our_packages_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/my_favorites_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/booking_section.dart';
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
  final GlobalKey _ourPackagesSectionKey =
      GlobalKey(); // New key for OurPackagesSection
  final GlobalKey _favoritesSectionKey =
      GlobalKey(); // Key for MyFavoritesSection
  final GlobalKey _bookingSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();

  // Hover states for AppBar buttons
  bool _isInicioHovered = false;
  bool _isPaquetesHovered = false;
  bool _isReservarHovered = false;
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
      title: 'Enchanting Paris',
      price: '\$1500',
      priceValue: 1500,
      location: 'Paris, France',
      continent: 'Europe',
      country: 'France',
      description:
          'Experience the city of lights, iconic landmarks, and romantic ambiance.',
      duration: '5 Days / 4 Nights',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Romantic',
      services: ['Flights', 'Guided Tours', 'Meals Included'],
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    PackageTravel(
      title: 'Ancient Rome Adventure',
      price: '\$1350',
      priceValue: 1350,
      location: 'Rome, Italy',
      continent: 'Europe',
      country: 'Italy',
      description:
          'Explore historical ruins, magnificent art, and delicious Italian cuisine.',
      duration: '6 Days / 5 Nights',
      durationDays: 6,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Adventure',
      services: ['Flights', 'Guided Tours'],
      imageUrl:
          'https://images.unsplash.com/photo-1529260830199-42c24126f198?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    PackageTravel(
      title: 'Mystical Kyoto Journey',
      price: '\$1800',
      priceValue: 1800,
      location: 'Kyoto, Japan',
      continent: 'Asia',
      country: 'Japan',
      description:
          'Discover serene temples, beautiful gardens, and traditional Japanese culture.',
      duration: '7 Days / 6 Nights',
      durationDays: 7,
      flightsIncluded: false,
      hotelRating: '5 Stars',
      guidedTours: true,
      category: 'Luxury',
      services: ['Hotel 5★', 'Guided Tours', 'Meals Included'],
      imageUrl:
          'https://images.unsplash.com/photo-1545569341-9eb8b30979d9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Define a base style for the AppBar text
    const double defaultFontSize = 18.0;
    const double hoverFontSize = 20.0; // Slightly larger on hover
    const Duration animationDuration = Duration(
      milliseconds: 200,
    ); // Animation duration
    final double hoverScale = hoverFontSize / defaultFontSize;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF072A47,
        ), // AppBar color with new value #072A47
        toolbarHeight: 70, // Increased toolbar height
        automaticallyImplyLeading:
            false, // Remove default leading widget (e.g., back button)
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute space
          children: [
            // Left side: Brand Name with Icon
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // So the Row doesn't take full width
                children: [
                  Image.asset(
                    'assets/images/icons8-airport-50.png',
                    width: 48.0,
                    height: 48.0,
                    color: const Color(0xFFFFDC00),
                  ), // Image for the brand
                  const SizedBox(width: 8), // Spacing between icon and text
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: defaultFontSize + 2,
                        fontFamily: 'LetyTravelsFont',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'ByLety'),
                        TextSpan(
                          text: 'Travels',
                          style: TextStyle(
                            color: Color(0xFFFFDC00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Center: Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  onEnter: (_) => setState(() => _isInicioHovered = true),
                  onExit: (_) => setState(() => _isInicioHovered = false),
                  child: TextButton(
                    onPressed: () => _scrollToSection(_heroSectionKey),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ), // Add some padding
                    ),
                    child: AnimatedScale(
                      scale: _isInicioHovered ? hoverScale : 1.0,
                      duration: animationDuration,
                      curve: Curves.easeInOut,
                      child: AnimatedDefaultTextStyle(
                        duration: animationDuration,
                        curve: Curves.easeInOut,
                        style: TextStyle(
                          color:
                              _isInicioHovered
                                  ? Color(0xFFFFDC00)
                                  : Colors.white,
                          fontSize:
                              defaultFontSize, // Base font size, scaling handles visual size change
                          fontFamily: 'LetyTravelsFont', // Apply custom font
                        ),
                        child: const Text('Inicio'),
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) => setState(() => _isPaquetesHovered = true),
                  onExit: (_) => setState(() => _isPaquetesHovered = false),
                  child: TextButton(
                    onPressed:
                        () => _scrollToSection(_popularDestinationsSectionKey),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: AnimatedScale(
                      scale: _isPaquetesHovered ? hoverScale : 1.0,
                      duration: animationDuration,
                      curve: Curves.easeInOut,
                      child: AnimatedDefaultTextStyle(
                        duration: animationDuration,
                        curve: Curves.easeInOut,
                        style: TextStyle(
                          color:
                              _isPaquetesHovered
                                  ? Color(0xFFFFDC00)
                                  : Colors.white,
                          fontSize: defaultFontSize,
                          fontFamily: 'LetyTravelsFont', // Apply custom font
                        ),
                        child: const Text('Paquetes'),
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) => setState(() => _isReservarHovered = true),
                  onExit: (_) => setState(() => _isReservarHovered = false),
                  child: TextButton(
                    onPressed: () => _scrollToSection(_bookingSectionKey),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: AnimatedScale(
                      scale: _isReservarHovered ? hoverScale : 1.0,
                      duration: animationDuration,
                      curve: Curves.easeInOut,
                      child: AnimatedDefaultTextStyle(
                        duration: animationDuration,
                        curve: Curves.easeInOut,
                        style: TextStyle(
                          color:
                              _isReservarHovered
                                  ? Color(0xFFFFDC00)
                                  : Colors.white,
                          fontSize: defaultFontSize,
                          fontFamily: 'LetyTravelsFont', // Apply custom font
                        ),
                        child: const Text('Reservar'),
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) => setState(() => _isContactoHovered = true),
                  onExit: (_) => setState(() => _isContactoHovered = false),
                  child: TextButton(
                    onPressed: () => _scrollToSection(_contactSectionKey),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: AnimatedScale(
                      scale: _isContactoHovered ? hoverScale : 1.0,
                      duration: animationDuration,
                      curve: Curves.easeInOut,
                      child: AnimatedDefaultTextStyle(
                        duration: animationDuration,
                        curve: Curves.easeInOut,
                        style: TextStyle(
                          color:
                              _isContactoHovered
                                  ? Color(0xFFFFDC00)
                                  : Colors.white,
                          fontSize: defaultFontSize,
                          fontFamily: 'LetyTravelsFont', // Apply custom font
                        ),
                        child: const Text('Contacto'),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Right side: Social Media + "Reservar Ahora" Button
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
              ), // Add some right padding
              child: Row(
                children: [
                  // Social media icons
                  const SocialMediaLinksCompact(),
                  const SizedBox(width: 24),
                  // Reservar button
                  ElevatedButton(
                    onPressed: () => _scrollToSection(_bookingSectionKey),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets
                              .zero, // Padding is handled by the inner Container
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), // Pill-shaped button
                      ),
                      elevation: 0, // No elevation, gradient is the focus
                      backgroundColor:
                          Colors.transparent, // Button itself is transparent
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(
                              255,
                              255,
                              196,
                              0,
                            ), // Left color: yellow
                            Color(0xFFD97806), // Right color: orange
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Match button shape
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '¡Reservar Ahora!',
                          style: TextStyle(
                            fontFamily: 'LetyTravelsFont',
                            fontSize:
                                defaultFontSize -
                                3, // Slightly smaller for button
                            color: const Color.fromARGB(
                              255,
                              247,
                              247,
                              247,
                            ), // Dark text for contrast
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchResultsPage(),
                ),
              );
            },
            tooltip: 'Search Packages',
          ),
          // Favorites badge
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final count = favoritesProvider.favoritesCount;

              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.white),
                    onPressed: () {
                      // TODO: Navigate to favorites section
                      _scrollToSection(_favoritesSectionKey);
                    },
                    tooltip: 'My Favorites',
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
      body: Stack(
        children: [
          SingleChildScrollView(
            // Keep SingleChildScrollView for overall page scroll
            child: Column(
              children: <Widget>[
                HeroSection(sectionKey: _heroSectionKey),
                // New Filterable Packages Section with Advanced Filters
                FilterablePackagesSection(
                  sectionKey: _popularDestinationsSectionKey,
                  allPackages: SamplePackages.allPackages,
                ),
                OurPackagesSection(
                  sectionKey: _ourPackagesSectionKey,
                ), // Use the new, unique key
                MyFavoritesSection(sectionKey: _favoritesSectionKey),
                BookingSection(sectionKey: _bookingSectionKey),

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
