// lib/data/models/package_travel.dart

// Represents a single day in a package itinerary.
class DayItinerary {
  final int dayNumber;
  final String title;
  final List<String> activities;
  final String meals; // e.g., "Breakfast, Lunch, Dinner"

  const DayItinerary({
    required this.dayNumber,
    required this.title,
    required this.activities,
    this.meals = '',
  });
}

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

  // Additional fields for filtering
  final double priceValue; // Numeric price for filtering
  final String continent; // Continent (Europe, Asia, America, etc.)
  final String country; // Country name
  final int durationDays; // Duration in days for filtering
  final String category; // Adventure, Romantic, Family, Luxury
  final List<String> services; // List of included services

  // Additional fields for sorting
  final int popularityScore; // Score for popularity (0-100)
  final DateTime? departureDate; // Next available departure date

  // Additional fields for badges and discounts
  final bool hasDiscount; // Has discount/sale
  final double? originalPrice; // Original price before discount
  final int? discountPercentage; // Discount percentage (e.g., 20 for 20%)
  final bool isNew; // Is a new package
  final bool isPopular; // Is a popular package (badge)
  final bool hasLimitedSeats; // Has limited availability
  final int? availableSeats; // Number of seats available

  // Additional fields for package details modal
  final List<String> galleryImages; // URLs of gallery images (5-10 photos)
  final List<DayItinerary> itinerary; // Day-by-day itinerary
  final List<String> inclusions; // What's included (meals, transfers, etc.)
  final List<String> exclusions; // What's not included (insurance, tips, etc.)
  final String termsAndConditions; // T&C text
  final List<DateTime> availableDates; // Available departure dates
  final double latitude; // Location latitude for map
  final double longitude; // Location longitude for map

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
    required this.priceValue,
    required this.continent,
    required this.country,
    required this.durationDays,
    required this.category,
    this.services = const [],
    this.popularityScore = 50, // Default popularity
    this.departureDate, // Optional departure date
    this.hasDiscount = false,
    this.originalPrice,
    this.discountPercentage,
    this.isNew = false,
    this.isPopular = false,
    this.hasLimitedSeats = false,
    this.availableSeats,
    this.galleryImages = const [],
    this.itinerary = const [],
    this.inclusions = const [],
    this.exclusions = const [],
    this.termsAndConditions = '',
    this.availableDates = const [],
    this.latitude = 0.0,
    this.longitude = 0.0,
  });
}
