import 'package:by_lety_travels/data/models/package_travel.dart';

/// Sample travel packages data for demonstration and testing
class SamplePackages {
  static final List<PackageTravel> allPackages = [
    // Europe - Romantic (POPULAR + DISCOUNT)
    PackageTravel(
      title: 'París Encantador',
      price: '\$1200',
      priceValue: 1200,
      location: 'París, Francia',
      continent: 'Europa',
      country: 'Francia',
      description:
          'Experimenta la ciudad de las luces, monumentos icónicos y ambiente romántico.',
      duration: '5 Días / 4 Noches',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Romántico',
      services: ['Vuelos', 'Tours Guiados', 'Comidas Incluidas'],
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
          title: 'Llegada a París',
          activities: [
            'Traslado del aeropuerto al hotel',
            'Registro en hotel 4 estrellas',
            'Cena de bienvenida en bistró francés tradicional',
            'Paseo nocturno por el río Sena',
          ],
          meals: 'Cena',
        ),
        DayItinerary(
          dayNumber: 2,
          title: 'Tour de Monumentos Icónicos',
          activities: [
            'Visita a la Torre Eiffel con acceso sin fila',
            'Tour guiado por el Museo del Louvre',
            'Almuerzo en los Campos Elíseos',
            'Visita al Arco del Triunfo',
            'Crucero por el río Sena al atardecer',
          ],
          meals: 'Desayuno, Almuerzo',
        ),
        DayItinerary(
          dayNumber: 3,
          title: 'Montmartre y Cultura',
          activities: [
            'Explorar el barrio artístico de Montmartre',
            'Visita a la Basílica del Sagrado Corazón',
            'Plaza de los artistas (Place du Tertre)',
            'Experiencia de clase de cocina francesa',
            'Tarde libre para compras',
          ],
          meals: 'Desayuno',
        ),
        DayItinerary(
          dayNumber: 4,
          title: 'Excursión a Versalles',
          activities: [
            'Excursión de día completo al Palacio de Versalles',
            'Tour guiado del palacio y jardines',
            'Visita a la Finca de María Antonieta',
            'Regreso a París',
            'Cena de despedida con espectáculo en Moulin Rouge',
          ],
          meals: 'Desayuno, Cena',
        ),
        DayItinerary(
          dayNumber: 5,
          title: 'Salida',
          activities: [
            'Desayuno en el hotel',
            'Compras de última hora o visita a museos',
            'Check-out y traslado al aeropuerto',
            'Vuelo de salida',
          ],
          meals: 'Desayuno',
        ),
      ],
      inclusions: [
        'Vuelos ida y vuelta desde principales ciudades de EE.UU.',
        '4 noches de alojamiento en hotel 4 estrellas',
        'Desayuno diario',
        '3 almuerzos y 3 cenas según itinerario',
        'Todos los traslados y transporte',
        'Guía de habla hispana',
        'Entrada sin fila a la Torre Eiffel',
        'Entrada al Museo del Louvre con guía',
        'Crucero por el río Sena',
        'Entrada y tour del Palacio de Versalles',
        'Boleto para espectáculo de Moulin Rouge',
        'Clase de cocina francesa',
        'Todos los impuestos y cargos de servicio',
      ],
      exclusions: [
        'Seguro de viaje',
        'Gastos personales y propinas',
        'Comidas adicionales no mencionadas',
        'Actividades opcionales',
        'Tasas de visa (si aplica)',
        'Cargos de equipaje',
        'Impuestos aeroportuarios (si no están incluidos en el vuelo)',
      ],
      termsAndConditions: '''
• La reserva requiere un depósito del 30%, el pago completo vence 30 días antes de la salida
• Política de cancelación: reembolso del 100% si se cancela con 60+ días de anticipación, 50% entre 30-59 días, sin reembolso dentro de los 30 días
• Se requiere pasaporte válido (6 meses de validez)
• Se recomienda encarecidamente un seguro de viaje
• Los precios están sujetos a cambios según disponibilidad
• Se requiere un mínimo de 2 pasajeros para la salida
• Suplemento individual disponible para viajeros solos (+\$400)
• Los niños menores de 12 años reciben un 20% de descuento
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
      title: 'Aventura en la Antigua Roma',
      price: '\$1350',
      priceValue: 1350,
      location: 'Roma, Italia',
      continent: 'Europa',
      country: 'Italia',
      description:
          'Explora ruinas históricas, arte magnífico y deliciosa cocina italiana.',
      duration: '6 Días / 5 Noches',
      durationDays: 6,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Aventura',
      services: ['Vuelos', 'Tours Guiados'],
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
          title: 'Bienvenido a Roma',
          activities: [
            'Recogida en el aeropuerto y registro en el hotel',
            'Caminata de orientación por Trastevere',
            'Cena de bienvenida en trattoria local',
          ],
          meals: 'Cena',
        ),
        DayItinerary(
          dayNumber: 2,
          title: 'Roma Antigua',
          activities: [
            'Tour guiado del Coliseo con acceso subterráneo',
            'Exploración del Foro Romano',
            'Visita al Monte Palatino',
            'Almuerzo cerca de los monumentos',
          ],
          meals: 'Desayuno',
        ),
        DayItinerary(
          dayNumber: 3,
          title: 'Ciudad del Vaticano',
          activities: [
            'Entrada prioritaria a los Museos Vaticanos',
            'Visita a la Capilla Sixtina',
            'Tour de la Basílica de San Pedro',
            'Subida a la cúpula (opcional)',
          ],
          meals: 'Desayuno',
        ),
        DayItinerary(
          dayNumber: 4,
          title: 'Roma Barroca',
          activities: [
            'Fontana de Trevi',
            'Escalinata de la Plaza de España',
            'Visita al Panteón',
            'Plaza Navona',
            'Tour de degustación de gelato',
          ],
          meals: 'Desayuno',
        ),
        DayItinerary(
          dayNumber: 5,
          title: 'Excursión a Pompeya',
          activities: [
            'Salida temprana a Pompeya',
            'Tour guiado de las ruinas antiguas',
            'Mirador del Monte Vesubio',
            'Regreso a Roma',
          ],
          meals: 'Desayuno, Almuerzo',
        ),
        DayItinerary(
          dayNumber: 6,
          title: 'Salida',
          activities: [
            'Mañana libre',
            'Últimas compras en Via del Corso',
            'Traslado al aeropuerto',
          ],
          meals: 'Desayuno',
        ),
      ],
      inclusions: [
        'Vuelos ida y vuelta',
        '5 noches en hotel 4 estrellas',
        'Desayuno diario',
        'Entradas sin fila al Coliseo',
        'Entrada prioritaria a Museos Vaticanos',
        'Guía profesional de habla hispana',
        'Excursión de día a Pompeya con transporte',
        'Todas las entradas mencionadas',
        'Traslados aeropuerto',
      ],
      exclusions: [
        'Seguro de viaje',
        'Almuerzos y cenas (excepto los mencionados)',
        'Gastos personales',
        'Propinas para guías',
        'Actividades opcionales',
      ],
      termsAndConditions: '''
• Se requiere un depósito del 30% para confirmar la reserva
• Pago completo 45 días antes de la salida
• Se aplican tarifas de cancelación
• Se requiere pasaporte válido
• Se recomienda seguro de viaje
• Zapatos cómodos para caminar esenciales
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
      title: 'Viaje Místico a Kioto',
      price: '\$1800',
      priceValue: 1800,
      location: 'Kioto, Japón',
      continent: 'Asia',
      country: 'Japón',
      description:
          'Descubre templos serenos, hermosos jardines y cultura japonesa tradicional.',
      duration: '7 Días / 6 Noches',
      durationDays: 7,
      flightsIncluded: false,
      hotelRating: '5 Estrellas',
      guidedTours: true,
      category: 'Lujo',
      services: ['Hotel 5★', 'Tours Guiados', 'Comidas Incluidas'],
      popularityScore: 92,
      departureDate: DateTime(2024, 8, 10),
      isPopular: true,
      imageUrl:
          'https://images.unsplash.com/photo-1545569341-9eb8b30979d9?q=80&w=2070&auto=format&fit=crop',
    ),

    // Asia - Adventure (DISCOUNT + LIMITED SEATS)
    PackageTravel(
      title: 'Tour de Comida Callejera en Bangkok',
      price: '\$712',
      priceValue: 712,
      location: 'Bangkok, Tailandia',
      continent: 'Asia',
      country: 'Tailandia',
      description:
          'Sumérgete en vibrantes mercados callejeros, templos y auténtica cocina tailandesa.',
      duration: '4 Días / 3 Noches',
      durationDays: 4,
      flightsIncluded: true,
      hotelRating: '3 Estrellas',
      guidedTours: true,
      category: 'Aventura',
      services: ['Vuelos', 'Tours Guiados', 'Comidas Incluidas'],
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
      title: 'Diversión Familiar en Nueva York',
      price: '\$2100',
      priceValue: 2100,
      location: 'Nueva York, EE.UU.',
      continent: 'América',
      country: 'EE.UU.',
      description:
          'Vacaciones familiares perfectas con espectáculos de Broadway, Central Park y atracciones icónicas.',
      duration: '6 Días / 5 Noches',
      durationDays: 6,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Familiar',
      services: ['Vuelos', 'Tours Guiados'],
      popularityScore: 90,
      departureDate: DateTime(2024, 7, 1),
      isNew: true,
      imageUrl:
          'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?q=80&w=2070&auto=format&fit=crop',
    ),

    // America - Luxury (DISCOUNT)
    PackageTravel(
      title: 'Río de Janeiro de Lujo',
      price: '\$2560',
      priceValue: 2560,
      location: 'Río de Janeiro, Brasil',
      continent: 'América',
      country: 'Brasil',
      description:
          'Experimenta hoteles de lujo frente a la playa, Copacabana y vistas impresionantes desde el Cristo Redentor.',
      duration: '8 Días / 7 Noches',
      durationDays: 8,
      flightsIncluded: true,
      hotelRating: '5 Estrellas',
      guidedTours: true,
      category: 'Lujo',
      services: ['Vuelos', 'Hotel 5★', 'Tours Guiados', 'Comidas Incluidas'],
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
      title: 'Safari en Kenia',
      price: '\$2800',
      priceValue: 2800,
      location: 'Nairobi, Kenia',
      continent: 'África',
      country: 'Kenia',
      description:
          'Presencia la Gran Migración y encuentra vida silvestre majestuosa en su hábitat natural.',
      duration: '10 Días / 9 Noches',
      durationDays: 10,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Aventura',
      services: ['Vuelos', 'Tours Guiados', 'Comidas Incluidas'],
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
      title: 'Explorador de las Pirámides Egipcias',
      price: '\$1650',
      priceValue: 1650,
      location: 'El Cairo, Egipto',
      continent: 'África',
      country: 'Egipto',
      description:
          'Descubre misterios antiguos en las Pirámides de Giza y explora el río Nilo.',
      duration: '7 Días / 6 Noches',
      durationDays: 7,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Aventura',
      services: ['Vuelos', 'Tours Guiados', 'Comidas Incluidas'],
      popularityScore: 82,
      departureDate: DateTime(2024, 10, 5),
      imageUrl:
          'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?q=80&w=2070&auto=format&fit=crop',
    ),

    // Oceania - Luxury
    PackageTravel(
      title: 'Sueño Australiano',
      price: '\$3500',
      priceValue: 3500,
      location: 'Sídney, Australia',
      continent: 'Oceanía',
      country: 'Australia',
      description:
          'Explora la Ópera de Sídney, la Gran Barrera de Coral y playas prístinas.',
      duration: '12 Días / 11 Noches',
      durationDays: 12,
      flightsIncluded: true,
      hotelRating: '5 Estrellas',
      guidedTours: true,
      category: 'Lujo',
      services: ['Vuelos', 'Hotel 5★', 'Tours Guiados', 'Comidas Incluidas'],
      popularityScore: 87,
      departureDate: DateTime(2024, 11, 10),
      imageUrl:
          'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?q=80&w=2070&auto=format&fit=crop',
    ),

    // Europe - Romantic (POPULAR)
    PackageTravel(
      title: 'Romance en Venecia',
      price: '\$1750',
      priceValue: 1750,
      location: 'Venecia, Italia',
      continent: 'Europa',
      country: 'Italia',
      description:
          'Paseos en góndola por canales románticos, Basílica de San Marcos y cocina italiana.',
      duration: '5 Días / 4 Noches',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '4 Estrellas',
      guidedTours: true,
      category: 'Romántico',
      services: ['Vuelos', 'Tours Guiados', 'Comidas Incluidas'],
      popularityScore: 91,
      departureDate: DateTime(2024, 6, 28),
      isPopular: true,
      imageUrl:
          'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?q=80&w=2083&auto=format&fit=crop',
    ),

    // Asia - Family
    PackageTravel(
      title: 'Aventura Familiar en Singapur',
      price: '\$2200',
      priceValue: 2200,
      location: 'Singapur',
      continent: 'Asia',
      country: 'Singapur',
      description:
          'Universal Studios, Gardens by the Bay y atracciones para toda la familia.',
      duration: '5 Días / 4 Noches',
      durationDays: 5,
      flightsIncluded: true,
      hotelRating: '5 Estrellas',
      guidedTours: false,
      category: 'Familiar',
      services: ['Vuelos', 'Hotel 5★'],
      popularityScore: 89,
      departureDate: DateTime(2024, 7, 20),
      imageUrl:
          'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?q=80&w=2052&auto=format&fit=crop',
    ),

    // Europe - Adventure
    PackageTravel(
      title: 'Aventura en los Alpes Suizos',
      price: '\$2600',
      priceValue: 2600,
      location: 'Zúrich, Suiza',
      continent: 'Europa',
      country: 'Suiza',
      description:
          'Esquí, senderismo de montaña y vistas alpinas impresionantes.',
      duration: '7 Días / 6 Noches',
      durationDays: 7,
      flightsIncluded: true,
      hotelRating: '5 Estrellas',
      guidedTours: true,
      category: 'Aventura',
      services: ['Vuelos', 'Hotel 5★', 'Tours Guiados'],
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
