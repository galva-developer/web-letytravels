import 'package:flutter/material.dart';

// Widget for the main hero section of the home page.
class HeroSection extends StatelessWidget {
  final GlobalKey sectionKey;

  // Constructor requiring a GlobalKey to enable scrolling to this section.
  const HeroSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    // The main container for the hero section.
    // This content will be moved from home_page.dart
    return Container(
      key: sectionKey,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color.fromARGB(110, 0, 0, 0).withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover Your Next Adventure', // Placeholder title
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 223, 223, 223),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Amazing destinations at unbeatable prices.', // Placeholder subtitle
            style: TextStyle(fontSize: 18, color: Colors.blueGrey[700]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Placeholder action for the explore now button
            },
            child: const Text('Explore Now'),
          ),
        ],
      ),
    );
  }
}
