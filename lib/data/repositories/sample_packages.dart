import 'package:by_lety_travels/data/models/package_travel.dart';

/// Sample travel packages data for demonstration and testing
class SamplePackages {
  static final List<PackageTravel> allPackages = [
    // Europe - Romantic (POPULAR + DISCOUNT)
    PackageTravel(
      title: 'Enchanting Paris',
      price: '\$1200',
      priceValue: 1200,
      location: 'Paris, France',
      continent: 'Europe',
      country: 'France',
      description:
          'Experience the city of lights, iconic landmarks, and romantic ambiance.',
      duration: '5 Days / 4 Nights',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Romantic',
      services: ['Flights', 'Guided Tours', 'Meals Included'],
      popularityScore: 95,
      departureDate: DateTime(2024, 7, 15),
      hasDiscount: true,
      originalPrice: 1500,
      discountPercentage: 20,
      isPopular: true,
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2073&auto=format&fit=crop',
      galleryImages: [
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2073&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?q=80&w=1974&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?q=80&w=2020&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1509439581779-6298f75bf6e5?q=80&w=1887&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1431274172761-fca41d930114?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1508050919630-b135583b29ab?q=80&w=2071&auto=format&fit=crop',
      ],
      itinerary: [
        DayItinerary(
          dayNumber: 1,
          title: 'Arrival in Paris',
          activities: [
            'Airport transfer to hotel',
            'Check-in at 4-star hotel',
            'Welcome dinner at traditional French bistro',
            'Evening stroll along the Seine River',
          ],
          meals: 'Dinner',
        ),
        DayItinerary(
          dayNumber: 2,
          title: 'Iconic Landmarks Tour',
          activities: [
            'Visit the Eiffel Tower with skip-the-line access',
            'Guided tour of the Louvre Museum',
            'Lunch at Champs-Élysées',
            'Arc de Triomphe visit',
            'Seine River cruise at sunset',
          ],
          meals: 'Breakfast, Lunch',
        ),
        DayItinerary(
          dayNumber: 3,
          title: 'Montmartre & Culture',
          activities: [
            'Explore the artistic Montmartre district',
            'Visit Sacré-Cœur Basilica',
            'Artist square (Place du Tertre)',
            'French cooking class experience',
            'Free evening for shopping',
          ],
          meals: 'Breakfast',
        ),
        DayItinerary(
          dayNumber: 4,
          title: 'Versailles Day Trip',
          activities: [
            'Full-day excursion to Palace of Versailles',
            'Guided tour of the palace and gardens',
            'Marie Antoinette\'s Estate visit',
            'Return to Paris',
            'Farewell dinner with Moulin Rouge show',
          ],
          meals: 'Breakfast, Dinner',
        ),
        DayItinerary(
          dayNumber: 5,
          title: 'Departure',
          activities: [
            'Breakfast at hotel',
            'Last-minute shopping or museum visit',
            'Check-out and airport transfer',
            'Departure flight',
          ],
          meals: 'Breakfast',
        ),
      ],
      inclusions: [
        'Round-trip flights from major US cities',
        '4 nights accommodation in 4-star hotel',
        'Daily breakfast',
        '3 lunches and 3 dinners as per itinerary',
        'All transfers and transportation',
        'English-speaking guide',
        'Skip-the-line entrance to Eiffel Tower',
        'Louvre Museum entry with guide',
        'Seine River cruise',
        'Versailles Palace entry and tour',
        'Moulin Rouge show ticket',
        'French cooking class',
        'All taxes and service charges',
      ],
      exclusions: [
        'Travel insurance',
        'Personal expenses and tips',
        'Additional meals not mentioned',
        'Optional activities',
        'Visa fees (if applicable)',
        'Luggage fees',
        'Airport taxes (if not included in flight)',
      ],
      termsAndConditions: '''
• Booking requires 30% deposit, full payment due 30 days before departure
• Cancellation policy: 100% refund if cancelled 60+ days before, 50% if 30-59 days, no refund within 30 days
• Valid passport required (6 months validity)
• Travel insurance highly recommended
• Prices subject to change based on availability
• Minimum 2 passengers required for departure
• Single supplement available for solo travelers (+\$400)
• Children under 12 receive 20% discount
''',
      availableDates: [
        DateTime(2024, 7, 15),
        DateTime(2024, 8, 5),
        DateTime(2024, 9, 10),
        DateTime(2024, 10, 1),
      ],
      latitude: 48.8566,
      longitude: 2.3522,
    ),

    // Europe - Adventure (NEW + LIMITED SEATS)
    PackageTravel(
      title: 'Ancient Rome Adventure',
      price: '\$1350',
      priceValue: 1350,
      location: 'Rome, Italy',
      continent: 'Europe',
      country: 'Italy',
      description:
          'Explore historical ruins, magnificent art, and delicious Italian cuisine.',
      duration: '6 Days / 5 Nights',
      durationDays: 6,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Adventure',
      services: ['Flights', 'Guided Tours'],
      popularityScore: 88,
      departureDate: DateTime(2024, 6, 20),
      isNew: true,
      hasLimitedSeats: true,
      availableSeats: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1529260830199-42c24126f198?q=80&w=1974&auto=format&fit=crop',
      galleryImages: [
        'https://images.unsplash.com/photo-1529260830199-42c24126f198?q=80&w=1974&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1552832230-c0197dd311b5?q=80&w=1996&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1531572753322-ad063cecc140?q=80&w=1976&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1525874684015-58379d421a52?q=80&w=2070&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?q=80&w=2070&auto=format&fit=crop',
      ],
      itinerary: [
        DayItinerary(
          dayNumber: 1,
          title: 'Welcome to Rome',
          activities: [
            'Airport pickup and hotel check-in',
            'Orientation walk through Trastevere',
            'Welcome dinner at local trattoria',
          ],
          meals: 'Dinner',
        ),
        DayItinerary(
          dayNumber: 2,
          title: 'Ancient Rome',
          activities: [
            'Colosseum guided tour with underground access',
            'Roman Forum exploration',
            'Palatine Hill visit',
            'Lunch near the monuments',
          ],
          meals: 'Breakfast',
        ),
        DayItinerary(
          dayNumber: 3,
          title: 'Vatican City',
          activities: [
            'Vatican Museums priority entrance',
            'Sistine Chapel visit',
            'St. Peter\'s Basilica tour',
            'Climb to the dome (optional)',
          ],
          meals: 'Breakfast',
        ),
        DayItinerary(
          dayNumber: 4,
          title: 'Baroque Rome',
          activities: [
            'Trevi Fountain',
            'Spanish Steps',
            'Pantheon visit',
            'Piazza Navona',
            'Gelato tasting tour',
          ],
          meals: 'Breakfast',
        ),
        DayItinerary(
          dayNumber: 5,
          title: 'Day Trip to Pompeii',
          activities: [
            'Early departure to Pompeii',
            'Guided tour of ancient ruins',
            'Mt. Vesuvius viewpoint',
            'Return to Rome',
          ],
          meals: 'Breakfast, Lunch',
        ),
        DayItinerary(
          dayNumber: 6,
          title: 'Departure',
          activities: [
            'Leisure morning',
            'Last shopping at Via del Corso',
            'Airport transfer',
          ],
          meals: 'Breakfast',
        ),
      ],
      inclusions: [
        'Round-trip flights',
        '5 nights in 4-star hotel',
        'Daily breakfast',
        'Colosseum skip-the-line tickets',
        'Vatican Museums priority entrance',
        'Professional English-speaking guide',
        'Pompeii day trip with transportation',
        'All entrance fees mentioned',
        'Airport transfers',
      ],
      exclusions: [
        'Travel insurance',
        'Lunches and dinners (except mentioned)',
        'Personal expenses',
        'Tips for guides',
        'Optional activities',
      ],
      termsAndConditions: '''
• 30% deposit required to confirm booking
• Full payment 45 days before departure
• Cancellation fees apply
• Valid passport required
• Travel insurance recommended
• Comfortable walking shoes essential
''',
      availableDates: [
        DateTime(2024, 6, 20),
        DateTime(2024, 7, 25),
        DateTime(2024, 9, 15),
      ],
      latitude: 41.9028,
      longitude: 12.4964,
    ),

    // Asia - Luxury (POPULAR)
    PackageTravel(
      title: 'Mystical Kyoto Journey',
      price: '\$1800',
      priceValue: 1800,
      location: 'Kyoto, Japan',
      continent: 'Asia',
      country: 'Japan',
      description:
          'Discover serene temples, beautiful gardens, and traditional Japanese culture.',
      duration: '7 Days / 6 Nights',
      durationDays: 7,
      flightsIncluded: false,
      hotelRating: '5 Stars',
      guidedTours: true,
      category: 'Luxury',
      services: ['Hotel 5★', 'Guided Tours', 'Meals Included'],
      popularityScore: 92,
      departureDate: DateTime(2024, 8, 10),
      isPopular: true,
      imageUrl:
          'https://images.unsplash.com/photo-1545569341-9eb8b30979d9?q=80&w=2070&auto=format&fit=crop',
    ),

    // Asia - Adventure (DISCOUNT + LIMITED SEATS)
    PackageTravel(
      title: 'Bangkok Street Food Tour',
      price: '\$712',
      priceValue: 712,
      location: 'Bangkok, Thailand',
      continent: 'Asia',
      country: 'Thailand',
      description:
          'Immerse yourself in vibrant street markets, temples, and authentic Thai cuisine.',
      duration: '4 Days / 3 Nights',
      durationDays: 4,
      flightsIncluded: true,
      hotelRating: '3 Stars',
      guidedTours: true,
      category: 'Adventure',
      services: ['Flights', 'Guided Tours', 'Meals Included'],
      popularityScore: 78,
      departureDate: DateTime(2024, 6, 5),
      hasDiscount: true,
      originalPrice: 890,
      discountPercentage: 20,
      hasLimitedSeats: true,
      availableSeats: 5,
      imageUrl:
          'https://images.unsplash.com/photo-1508009603885-50cf7c579365?q=80&w=2050&auto=format&fit=crop',
    ),

    // America - Family (NEW)
    PackageTravel(
      title: 'New York City Family Fun',
      price: '\$2100',
      priceValue: 2100,
      location: 'New York, USA',
      continent: 'America',
      country: 'USA',
      description:
          'Perfect family vacation with Broadway shows, Central Park, and iconic attractions.',
      duration: '6 Days / 5 Nights',
      durationDays: 6,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Family',
      services: ['Flights', 'Guided Tours'],
      popularityScore: 90,
      departureDate: DateTime(2024, 7, 1),
      isNew: true,
      imageUrl:
          'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?q=80&w=2070&auto=format&fit=crop',
    ),

    // America - Luxury (DISCOUNT)
    PackageTravel(
      title: 'Luxury Rio de Janeiro',
      price: '\$2560',
      priceValue: 2560,
      location: 'Rio de Janeiro, Brazil',
      continent: 'America',
      country: 'Brazil',
      description:
          'Experience luxury beachfront hotels, Copacabana, and stunning views from Christ the Redeemer.',
      duration: '8 Days / 7 Nights',
      durationDays: 8,
      flightsIncluded: true,
      hotelRating: '5 Stars',
      guidedTours: true,
      category: 'Luxury',
      services: ['Flights', 'Hotel 5★', 'Guided Tours', 'Meals Included'],
      popularityScore: 85,
      departureDate: DateTime(2024, 9, 15),
      hasDiscount: true,
      originalPrice: 3200,
      discountPercentage: 20,
      imageUrl:
          'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?q=80&w=2070&auto=format&fit=crop',
    ),

    // Africa - Adventure (POPULAR + LIMITED SEATS)
    PackageTravel(
      title: 'Safari in Kenya',
      price: '\$2800',
      priceValue: 2800,
      location: 'Nairobi, Kenya',
      continent: 'Africa',
      country: 'Kenya',
      description:
          'Witness the Great Migration and encounter majestic wildlife in their natural habitat.',
      duration: '10 Days / 9 Nights',
      durationDays: 10,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Adventure',
      services: ['Flights', 'Guided Tours', 'Meals Included'],
      popularityScore: 94,
      departureDate: DateTime(2024, 8, 20),
      isPopular: true,
      hasLimitedSeats: true,
      availableSeats: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1516426122078-c23e76319801?q=80&w=2068&auto=format&fit=crop',
    ),

    // Africa - Adventure
    PackageTravel(
      title: 'Egyptian Pyramids Explorer',
      price: '\$1650',
      priceValue: 1650,
      location: 'Cairo, Egypt',
      continent: 'Africa',
      country: 'Egypt',
      description:
          'Uncover ancient mysteries at the Pyramids of Giza and explore the Nile River.',
      duration: '7 Days / 6 Nights',
      durationDays: 7,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Adventure',
      services: ['Flights', 'Guided Tours', 'Meals Included'],
      popularityScore: 82,
      departureDate: DateTime(2024, 10, 5),
      imageUrl:
          'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?q=80&w=2070&auto=format&fit=crop',
    ),

    // Oceania - Luxury
    PackageTravel(
      title: 'Australian Dream',
      price: '\$3500',
      priceValue: 3500,
      location: 'Sydney, Australia',
      continent: 'Oceania',
      country: 'Australia',
      description:
          'Explore Sydney Opera House, Great Barrier Reef, and pristine beaches.',
      duration: '12 Days / 11 Nights',
      durationDays: 12,
      flightsIncluded: true,
      hotelRating: '5 Stars',
      guidedTours: true,
      category: 'Luxury',
      services: ['Flights', 'Hotel 5★', 'Guided Tours', 'Meals Included'],
      popularityScore: 87,
      departureDate: DateTime(2024, 11, 10),
      imageUrl:
          'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?q=80&w=2070&auto=format&fit=crop',
    ),

    // Europe - Romantic (POPULAR)
    PackageTravel(
      title: 'Venice Romance',
      price: '\$1750',
      priceValue: 1750,
      location: 'Venice, Italy',
      continent: 'Europe',
      country: 'Italy',
      description:
          'Gondola rides through romantic canals, St. Mark\'s Basilica, and Italian cuisine.',
      duration: '5 Days / 4 Nights',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '4 Stars',
      guidedTours: true,
      category: 'Romantic',
      services: ['Flights', 'Guided Tours', 'Meals Included'],
      popularityScore: 91,
      departureDate: DateTime(2024, 6, 28),
      isPopular: true,
      imageUrl:
          'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?q=80&w=2083&auto=format&fit=crop',
    ),

    // Asia - Family
    PackageTravel(
      title: 'Singapore Family Adventure',
      price: '\$2200',
      priceValue: 2200,
      location: 'Singapore',
      continent: 'Asia',
      country: 'Singapore',
      description:
          'Universal Studios, Gardens by the Bay, and family-friendly attractions.',
      duration: '5 Days / 4 Nights',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '5 Stars',
      guidedTours: false,
      category: 'Family',
      services: ['Flights', 'Hotel 5★'],
      popularityScore: 89,
      departureDate: DateTime(2024, 7, 20),
      imageUrl:
          'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?q=80&w=2052&auto=format&fit=crop',
    ),

    // Europe - Adventure
    PackageTravel(
      title: 'Swiss Alps Adventure',
      price: '\$2600',
      priceValue: 2600,
      location: 'Zurich, Switzerland',
      continent: 'Europe',
      country: 'Switzerland',
      description: 'Skiing, mountain hiking, and breathtaking Alpine views.',
      duration: '7 Days / 6 Nights',
      durationDays: 7,
      flightsIncluded: true,
      hotelRating: '5 Stars',
      guidedTours: true,
      category: 'Adventure',
      services: ['Flights', 'Hotel 5★', 'Guided Tours'],
      popularityScore: 80,
      departureDate: DateTime(2024, 12, 1),
      imageUrl:
          'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?q=80&w=2070&auto=format&fit=crop',
    ),
  ];

  /// Get packages filtered by continent
  static List<PackageTravel> getPackagesByContinent(String continent) {
    return allPackages
        .where((package) => package.continent == continent)
        .toList();
  }

  /// Get packages filtered by category
  static List<PackageTravel> getPackagesByCategory(String category) {
    return allPackages
        .where((package) => package.category == category)
        .toList();
  }

  /// Get packages within price range
  static List<PackageTravel> getPackagesByPriceRange(
    double minPrice,
    double maxPrice,
  ) {
    return allPackages
        .where(
          (package) =>
              package.priceValue >= minPrice && package.priceValue <= maxPrice,
        )
        .toList();
  }
}
