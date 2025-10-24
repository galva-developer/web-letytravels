import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/presentation/widgets/travel_package_card.dart';
import 'package:by_lety_travels/presentation/pages/booking_form_page.dart';

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
    final isMobile = MediaQuery.of(context).size.width < 768;

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
          LayoutBuilder(
            builder: (context, constraints) {
              final maxCardWidth = isMobile ? constraints.maxWidth : 580.0;
              // Mobile: 370px minimum, Desktop: 580px minimum
              final minCardWidth = isMobile ? 370.0 : 580.0;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: maxCardWidth,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  mainAxisExtent: isMobile ? 580.0 : 650.0,
                ),
                itemCount: popularDestinations.length,
                itemBuilder: (context, index) {
                  final package = popularDestinations[index];

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: minCardWidth,
                      maxWidth: maxCardWidth,
                    ),
                    child: TravelPackageCard(
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
                        // Navigate to booking form page
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => BookingFormPage(package: package),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
