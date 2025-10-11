import 'package:flutter/material.dart';

// Placeholder widget for a future booking section.
class BookingSection extends StatelessWidget {
  final GlobalKey sectionKey;

  // Constructor requiring a GlobalKey.
  const BookingSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    // Container serving as a placeholder for the booking section.
    return Container(
      key: sectionKey,
      height: 300, // Example height
      color: Colors.teal[100], // Distinct color for placeholder
      alignment: Alignment.center,
      child: const Text(
        'Reservar Section - Placeholder', // Placeholder text
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
