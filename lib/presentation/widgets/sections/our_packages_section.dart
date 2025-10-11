import 'package:flutter/material.dart';

// Widget to display a list of various travel packages.
class OurPackagesSection extends StatelessWidget {
  final GlobalKey sectionKey;

  // Constructor requiring a GlobalKey.
  const OurPackagesSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    // Padding wrapper for the section.
    // This content will be moved from home_page.dart
    return Padding(
      key: sectionKey,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Packages', // Section title
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.card_travel),
            title: Text('Weekend Getaway'), // Example package
            subtitle: Text('Explore nearby cities with our special package.'),
          ),
          const ListTile(
            leading: Icon(Icons.beach_access),
            title: Text('Beach Holiday'), // Example package
            subtitle: Text('Relax and unwind at stunning beach resorts.'),
          ),
          // Add more packages or a dynamic list here
        ],
      ),
    );
  }
}
