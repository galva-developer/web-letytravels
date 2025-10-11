import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/package_travel.dart'; // Import the model
import 'package:by_lety_travels/presentation/widgets/sections/hero_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/popular_destinations_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/our_packages_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/booking_section.dart';
import 'package:by_lety_travels/presentation/widgets/sections/contact_footer_section.dart';

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
      price: '\$1500', // Corrected dollar sign
      location: 'Paris, France',
      description:
          'Experience the city of lights, iconic landmarks, and romantic ambiance.',
      duration: '5 Days / 4 Nights',
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    PackageTravel(
      title: 'Ancient Rome Adventure',
      price: '\$1350', // Corrected dollar sign
      location: 'Rome, Italy',
      description:
          'Explore historical ruins, magnificent art, and delicious Italian cuisine.',
      duration: '6 Days / 5 Nights',
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      imageUrl:
          'https://images.unsplash.com/photo-1529260830199-42c24126f198?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    PackageTravel(
      title: 'Mystical Kyoto Journey',
      price: '\$1800', // Corrected dollar sign
      location: 'Kyoto, Japan',
      description:
          'Discover serene temples, beautiful gardens, and traditional Japanese culture.',
      duration: '7 Days / 6 Nights',
      flightsIncluded: false,
      hotelRating: '5 Stars',
      guidedTours: true,
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

            // Right side: "Reservar Ahora" Button
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
              ), // Add some right padding
              child: ElevatedButton(
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
                        Color.fromARGB(255, 255, 196, 0), // Left color: yellow
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
                            defaultFontSize - 3, // Slightly smaller for button
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
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Keep SingleChildScrollView for overall page scroll
        child: Column(
          children: <Widget>[
            HeroSection(sectionKey: _heroSectionKey),
            PopularDestinationsSection(
              sectionKey: _popularDestinationsSectionKey, // Use the renamed key
              popularDestinations: popularDestinations,
            ),
            OurPackagesSection(
              sectionKey: _ourPackagesSectionKey,
            ), // Use the new, unique key
            BookingSection(sectionKey: _bookingSectionKey),
            ContactFooterSection(sectionKey: _contactSectionKey),
          ],
        ),
      ),
    );
  }
}
