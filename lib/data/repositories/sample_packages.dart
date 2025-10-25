import 'package:by_lety_travels/data/models/package_travel.dart';

/// Sample travel packages data for demonstration and testing
class SamplePackages {
  static final List<PackageTravel> allPackages = [
    // South America - Beach/Adventure (NEW + FAMILY FRIENDLY)
    PackageTravel(
      title: 'Brasil - Búzios',
      price: '\$850 USD',
      priceValue: 850,
      location: 'Búzios, Brasil',
      continent: 'América del Sur',
      country: 'Brasil',
      description:
          '16 días mágicos recorriendo Río de Janeiro, Búzios, Cabo Frío y Arraial do Cabo. Playas de aguas cristalinas, paisajes de postal y momentos únicos.',
      duration: '16 Días / 15 Noches',
      durationDays: 16,
      flightsIncluded: false,
      hotelRating: 'Casas con Pileta',
      guidedTours: true,
      category: 'Playa',
      services: ['Traslado', 'Tours Guiados', 'Paseos en Barco'],
      popularityScore: 92,
      departureDate: DateTime(2026, 1, 8),
      isNew: true,
      isPopular: true,
      imageUrl:
          'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?q=80&w=2070&auto=format&fit=crop',
      galleryImages: [
        'https://i0.wp.com/www.centralbuzios.com/blog/wp-content/uploads/2016/01/Buzios-Brasil-Viajes_CLAIMA20150604_0113_29.jpg?ssl=1',
        'https://i0.wp.com/www.centralbuzios.com/blog/wp-content/uploads/2016/01/Buzios-Brasil-Viajes_CLAIMA20150604_0112_29.jpg?resize=850%2C567&ssl=1',
        'https://images3.bovpg.net/r/media/1/6/0/6/7/60672.jpg',
        'https://www.civitatis.com/f/brasil/cabo-frio/excursion-buzios-589x392.jpg',
        'https://static.hosteltur.com/app/public/uploads/img/articles/2020/12/18/L_093208_buzios.jpg',
      ],
      itinerary: [
        DayItinerary(
          dayNumber: 1,
          title: 'Salida y Viaje',
          activities: [
            'Salida desde el punto de encuentro',
            'Viaje en bus hacia Brasil',
            'Paradas de descanso',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 2,
          title: 'Llegada a Brasil',
          activities: [
            'Llegada a la región de Búzios',
            'Check-in en casa con pileta',
            'Bienvenida y orientación',
            'Descanso y ambientación',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 3,
          title: 'Tour Río de Janeiro',
          activities: [
            'Visita al Cristo Redentor',
            'Paseo por el Cerro Pan de Azúcar',
            'Escalera de Selarón',
            'Estadio Maracaná',
            'Sambódromo',
            'Almuerzo incluido',
          ],
          meals: 'Almuerzo',
        ),
        DayItinerary(
          dayNumber: 4,
          title: 'Playas de Búzios',
          activities: [
            'Paseo en barco por Búzios',
            'Visita a playas paradisíacas',
            'Tiempo libre para nadar y disfrutar',
            'Ambiente familiar y relajado',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 5,
          title: 'Arraial do Cabo - Caribe Brasilero',
          activities: [
            'Paseo en barco en Arraial do Cabo',
            'Visita a playas de aguas cristalinas',
            'Snorkel y natación',
            'Paisajes de postal',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 6,
          title: 'Cabo Frío',
          activities: [
            'Exploración de Cabo Frío',
            'Visita a playas locales',
            'Tiempo libre',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 7,
          title: 'Día Libre en Búzios',
          activities: [
            'Día libre para disfrutar',
            'Más de 24 playas paradisíacas para elegir',
            'Relax en casa con pileta',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 8,
          title: 'Día Libre en Búzios',
          activities: [
            'Día libre para disfrutar',
            'Exploración de playas',
            'Actividades opcionales',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 9,
          title: 'Día Libre en Búzios',
          activities: ['Día libre para disfrutar', 'Descanso y playa'],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 10,
          title: 'Día Libre en Búzios',
          activities: [
            'Día libre para disfrutar',
            'Última oportunidad de disfrutar las playas',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 11,
          title: 'Día Libre en Búzios',
          activities: [
            'Día libre para disfrutar',
            'Preparativos para el regreso',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 12,
          title: 'Día Libre en Búzios',
          activities: [
            'Día libre para disfrutar',
            'Últimos momentos en la playa',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 13,
          title: 'Día Libre en Búzios',
          activities: ['Día libre para disfrutar', 'Despedida de Búzios'],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 14,
          title: 'Inicio del Regreso',
          activities: ['Check-out de las casas', 'Viaje hacia Foz do Iguazú'],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 15,
          title: 'Foz do Iguazú y Cataratas',
          activities: [
            'Llegada a Hotel en Foz do Iguazú (1 noche)',
            'Visita a las Cataratas del Iguazú (lado brasilero)',
            'Paseo de compras en Ciudad del Este (opcional)',
          ],
          meals: '',
        ),
        DayItinerary(
          dayNumber: 16,
          title: 'Regreso',
          activities: [
            'Check-out del hotel',
            'Viaje de regreso',
            'Llegada al punto de partida',
          ],
          meals: '',
        ),
      ],
      inclusions: [
        'Traslado ida y vuelta en bus',
        'Hospedaje en casas con pileta (ambiente familiar)',
        'Tour completo de Río de Janeiro con almuerzo incluido',
        'Visita al Cristo Redentor',
        'Cerro Pan de Azúcar',
        'Escalera de Selarón',
        'Estadio Maracaná',
        'Sambódromo',
        'Paseo en barco en Búzios',
        'Paseo en barco en Arraial do Cabo (Caribe Brasilero)',
        'Acceso a más de 24 playas paradisíacas',
        '1 día y 1 noche en Hotel Foz do Iguazú (Brasil)',
        'Ticket de ingreso a Cataratas (lado brasilero)',
        'Guía y coordinación durante todo el viaje',
      ],
      exclusions: [
        'Alimentación (no incluye ningún tipo de comidas excepto el almuerzo del tour de Río)',
        'Gastos personales',
        'Propinas',
        'Paseo de compras en Ciudad del Este (opcional)',
        'Actividades adicionales no mencionadas',
        'Seguro de viaje',
        'Documentación necesaria (pasaporte, visas si aplica)',
      ],
      termsAndConditions: '''
• Señá tu lugar con \$us 300
• El resto se puede pagar en cuotas hasta la primera semana de diciembre
• Salidas disponibles: 8 de enero y 28 de enero de 2026
• Viaje de 16 días y 15 noches
• Alojamiento en casas con pileta, ambiente familiar
• No incluye alimentación excepto el almuerzo del tour de Río
• Se requiere documentación válida para ingreso a Brasil y Paraguay
• Mínimo de pasajeros para confirmar la salida
• Política de cancelación: consultar con By LetyTravels
''',
      availableDates: [DateTime(2026, 1, 8), DateTime(2026, 1, 28)],
      latitude: -22.7471,
      longitude: -41.8811,
    ),
    // Europe - Romantic (POPULAR + DISCOUNT)
    PackageTravel(
      title: 'París Encantador',
      price: '\$1200 USD',
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
      comingSoon: true,
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
      price: '\$1350 USD',
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
      comingSoon: true,
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
