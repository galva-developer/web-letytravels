import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/presentation/widgets/travel_package_card.dart';

// Widget to display a grid of popular travel destinations.
class PopularDestinationsSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final List<PackageTravel> popularDestinations;

  // Constructor requiring a GlobalKey and a list of PackageTravel objects.
  const PopularDestinationsSection({
    super.key,
    required this.sectionKey,
    required this.popularDestinations,
  });

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
            'Popular Destinations', // Section title
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3, // Display 3 items per row
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.75, // Adjust aspect ratio
            children:
                popularDestinations.map((package) {
                  return TravelPackageCard(
                    title: package.title,
                    price: package.price,
                    location: package.location,
                    description: package.description,
                    duration: package.duration,
                    flightsIncluded: package.flightsIncluded,
                    hotelRating: package.hotelRating,
                    guidedTours: package.guidedTours,
                    imageUrl: package.imageUrl,
                    onBookNowPressed: () {
                      print('Book Now pressed for: ${package.title}');
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
