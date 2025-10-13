import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:by_lety_travels/presentation/widgets/components/stats_indicator.dart';

// Widget for the main hero section of the home page with image carousel.
class HeroSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final VoidCallback? onExploreDestinations;

  // Constructor requiring a GlobalKey to enable scrolling to this section.
  const HeroSection({
    super.key,
    required this.sectionKey,
    this.onExploreDestinations,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  // Carousel controller to control the slider
  final carousel.CarouselSliderController _carouselController =
      carousel.CarouselSliderController();

  // Current slide index
  int _currentIndex = 0;

  // Auto-play state
  bool _isAutoPlaying = true;

  // Animation controllers
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonAnimation;

  // List of background images (background-0.jpg to background-5.jpg)
  final List<String> _backgroundImages = [
    'assets/images/background-0.jpg',
    'assets/images/background-1.jpg',
    'assets/images/background-2.jpg',
    'assets/images/background-3.jpg',
    'assets/images/background-4.jpg',
  ];

  // Rotating destinations for animated text
  final List<String> _destinations = [
    'Descubre París',
    'Explora Roma',
    'Experimenta Kioto',
    'Visita Nueva York',
    'Disfruta Bali',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize button bounce animation
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _buttonAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    // Start button bounce animation
    _buttonAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  // Open WhatsApp with predefined message
  Future<void> _openWhatsApp() async {
    const phoneNumber = '5493884102859'; // WhatsApp Business number
    const message = '¡Hola! Me gustaría información sobre paquetes de viaje.';
    final url = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      // Show error message if WhatsApp cannot be opened
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo abrir WhatsApp'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Scroll to packages section
  void _scrollToPackages() {
    if (widget.onExploreDestinations != null) {
      widget.onExploreDestinations!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.sectionKey,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          // Carousel Slider for Background Images
          carousel.CarouselSlider(
            carouselController: _carouselController,
            options: carousel.CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0, // Full width
              autoPlay: _isAutoPlaying, // Auto-play enabled
              autoPlayInterval: const Duration(
                seconds: 5,
              ), // Change every 5 seconds
              autoPlayAnimationDuration: const Duration(
                milliseconds: 1000,
              ), // Smooth transition
              autoPlayCurve: Curves.easeInOut, // Smooth curve
              pauseAutoPlayOnTouch: true, // Pause on user interaction
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items:
                _backgroundImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              const Color.fromARGB(
                                110,
                                0,
                                0,
                                0,
                              ).withOpacity(0.4),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
          ),

          // Content overlay (text and buttons)
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main title with fade-in animation
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: const Text(
                      'Descubre Tu Próxima Aventura',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 8,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Animated rotating text with typewriter effect
                  SizedBox(
                    height: 50,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFDC00),
                        shadows: [
                          Shadow(
                            offset: const Offset(1, 1),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ],
                      ),
                      child: AnimatedTextKit(
                        animatedTexts:
                            _destinations
                                .map(
                                  (destination) => TypewriterAnimatedText(
                                    destination,
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                )
                                .toList(),
                        repeatForever: true,
                        pause: const Duration(milliseconds: 1500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Subtitle with fade-in
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child) {
                      return Opacity(opacity: value, child: child);
                    },
                    child: Text(
                      'Destinos increíbles a precios inmejorables.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white.withOpacity(0.9),
                        shadows: [
                          Shadow(
                            offset: const Offset(1, 1),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Statistics indicators with animation
                  const StatsIndicator(),
                  const SizedBox(height: 40),

                  // Call-to-action buttons with bounce animation
                  AnimatedBuilder(
                    animation: _buttonAnimationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _buttonAnimation.value),
                        child: child,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Primary CTA: Explore Destinations
                        _buildPrimaryCTA(),
                        const SizedBox(width: 20),
                        // Secondary CTA: Contact Advisor via WhatsApp
                        _buildSecondaryCTA(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Carousel indicators (dots)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  _backgroundImages.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentIndex == entry.key
                                  ? const Color(0xFFFFDC00)
                                  : Colors.white.withOpacity(0.4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          // Navigation arrows (left and right)
          // Left arrow
          Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _carouselController.previousPage();
                    setState(() {
                      _isAutoPlaying =
                          false; // Stop auto-play on manual navigation
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Right arrow
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _carouselController.nextPage();
                    setState(() {
                      _isAutoPlaying =
                          false; // Stop auto-play on manual navigation
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build primary CTA button (Explore Destinations)
  Widget _buildPrimaryCTA() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton.icon(
        onPressed: _scrollToPackages,
        icon: const Icon(Icons.explore, size: 24),
        label: const Text('Explorar Destinos'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFDC00),
          foregroundColor: const Color(0xFF072A47),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return const Color(0xFF072A47).withOpacity(0.1);
            }
            if (states.contains(WidgetState.pressed)) {
              return const Color(0xFF072A47).withOpacity(0.2);
            }
            return null;
          }),
          elevation: WidgetStateProperty.resolveWith<double>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return 12;
            }
            if (states.contains(WidgetState.pressed)) {
              return 4;
            }
            return 8;
          }),
        ),
      ),
    );
  }

  // Build secondary CTA button (Contact via WhatsApp)
  Widget _buildSecondaryCTA() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: OutlinedButton.icon(
        onPressed: _openWhatsApp,
        icon: const Icon(Icons.chat, size: 24),
        label: const Text('Hablar con Asesor'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white.withOpacity(0.15),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.white.withOpacity(0.2);
            }
            if (states.contains(WidgetState.pressed)) {
              return Colors.white.withOpacity(0.3);
            }
            return null;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.white.withOpacity(0.25);
            }
            return Colors.white.withOpacity(0.15);
          }),
          elevation: WidgetStateProperty.resolveWith<double>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return 12;
            }
            if (states.contains(WidgetState.pressed)) {
              return 4;
            }
            return 8;
          }),
          side: WidgetStateProperty.resolveWith<BorderSide>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.hovered)) {
              return const BorderSide(color: Color(0xFFFFDC00), width: 2.5);
            }
            return const BorderSide(color: Colors.white, width: 2);
          }),
        ),
      ),
    );
  }
}
