import 'package:flutter/material.dart';

// Widget for the footer section, typically containing contact information or copyright.
class ContactFooterSection extends StatelessWidget {
  final GlobalKey sectionKey;

  // Constructor requiring a GlobalKey.
  const ContactFooterSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    // Container for the footer content.
    // This content will be moved from home_page.dart
    return Container(
      key: sectionKey,
      padding: const EdgeInsets.all(20.0),
      color: Colors.grey[800], // Dark color for footer
      child: const Center(
        child: Text(
          '© 2024 Lety Travels. All rights reserved. Contact us at contact@letytravels.com', // Placeholder footer text
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
