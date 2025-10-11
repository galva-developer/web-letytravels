// lib/data/models/package_travel.dart

// Represents a travel package with all its details.
class PackageTravel {
  final String title;
  final String price;
  final String location;
  final String description;
  final String duration;
  final bool flightsIncluded;
  final String hotelRating;
  final bool guidedTours;
  final String? imageUrl; // Optional image URL for the package

  // Constructor for the PackageTravel class.
  const PackageTravel({
    // Made constructor const
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.duration,
    required this.flightsIncluded,
    required this.hotelRating,
    required this.guidedTours,
    this.imageUrl, // This can be null if no image is available
  });
}
