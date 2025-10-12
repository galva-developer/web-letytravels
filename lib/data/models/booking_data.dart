/// Model for booking/reservation data
import 'package:by_lety_travels/data/models/coupon.dart';

class BookingData {
  // Información del Viajero
  final String firstName;
  final String lastName;
  final String email;
  final String phoneCountryCode;
  final String phoneNumber;
  final String countryOfResidence;
  final DateTime? birthDate;
  final String? passportNumber;

  // Detalles de la Reserva
  final String packageTitle;
  final DateTime? departureDate;
  final int numberOfAdults;
  final int numberOfChildren; // 0-12 años
  final int numberOfInfants; // 0-2 años
  final RoomType roomType;

  // Servicios Adicionales
  final bool travelInsurance;
  final bool airportTransfer;
  final bool additionalTour;
  final bool hotelUpgrade;
  final bool preferredSeats;

  // Comentarios
  final String? specialRequests;

  // Cupón de descuento
  final Coupon? appliedCoupon;

  // Precios calculados
  final double basePrice;
  final double insurancePrice;
  final double transferPrice;
  final double tourPrice;
  final double upgradePrice;
  final double seatsPrice;
  final double taxRate; // Porcentaje de impuestos (ej: 0.05 = 5%)

  const BookingData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneCountryCode,
    required this.phoneNumber,
    required this.countryOfResidence,
    this.birthDate,
    this.passportNumber,
    required this.packageTitle,
    this.departureDate,
    this.numberOfAdults = 1,
    this.numberOfChildren = 0,
    this.numberOfInfants = 0,
    this.roomType = RoomType.double,
    this.travelInsurance = false,
    this.airportTransfer = false,
    this.additionalTour = false,
    this.hotelUpgrade = false,
    this.preferredSeats = false,
    this.specialRequests,
    this.appliedCoupon,
    required this.basePrice,
    this.insurancePrice = 50.0,
    this.transferPrice = 30.0,
    this.tourPrice = 100.0,
    this.upgradePrice = 200.0,
    this.seatsPrice = 40.0,
    this.taxRate = 0.05,
  });

  /// Calculate total travelers
  int get totalTravelers => numberOfAdults + numberOfChildren + numberOfInfants;

  /// Calculate subtotal based on base price and number of people
  double get subtotal {
    double total = basePrice * numberOfAdults;
    // Children usually pay 70% of adult price
    total += (basePrice * 0.7) * numberOfChildren;
    // Infants usually pay 10% of adult price (just taxes)
    total += (basePrice * 0.1) * numberOfInfants;
    return total;
  }

  /// Calculate additional services cost
  double get additionalServicesCost {
    double total = 0;
    if (travelInsurance) total += insurancePrice * totalTravelers;
    if (airportTransfer) total += transferPrice * totalTravelers;
    if (additionalTour) total += tourPrice * totalTravelers;
    if (hotelUpgrade) total += upgradePrice;
    if (preferredSeats)
      total += seatsPrice * (numberOfAdults + numberOfChildren);
    return total;
  }

  /// Calculate subtotal before discount (subtotal + services)
  double get subtotalBeforeDiscount => subtotal + additionalServicesCost;

  /// Calculate discount amount from coupon
  double get discountAmount {
    if (appliedCoupon == null) return 0;
    return appliedCoupon!.calculateDiscount(subtotalBeforeDiscount);
  }

  /// Calculate subtotal after discount
  double get subtotalAfterDiscount =>
      (subtotalBeforeDiscount - discountAmount).clamp(0, double.infinity);

  /// Calculate taxes (applied after discount)
  double get taxes => subtotalAfterDiscount * taxRate;

  /// Calculate total amount to pay (with discount applied)
  double get totalAmount => subtotalAfterDiscount + taxes;

  /// Copy with method for state updates
  BookingData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneCountryCode,
    String? phoneNumber,
    String? countryOfResidence,
    DateTime? birthDate,
    String? passportNumber,
    String? packageTitle,
    DateTime? departureDate,
    int? numberOfAdults,
    int? numberOfChildren,
    int? numberOfInfants,
    RoomType? roomType,
    bool? travelInsurance,
    bool? airportTransfer,
    bool? additionalTour,
    bool? hotelUpgrade,
    bool? preferredSeats,
    String? specialRequests,
    Coupon? appliedCoupon,
    bool clearCoupon = false,
    double? basePrice,
    double? insurancePrice,
    double? transferPrice,
    double? tourPrice,
    double? upgradePrice,
    double? seatsPrice,
    double? taxRate,
  }) {
    return BookingData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryOfResidence: countryOfResidence ?? this.countryOfResidence,
      birthDate: birthDate ?? this.birthDate,
      passportNumber: passportNumber ?? this.passportNumber,
      packageTitle: packageTitle ?? this.packageTitle,
      departureDate: departureDate ?? this.departureDate,
      numberOfAdults: numberOfAdults ?? this.numberOfAdults,
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
      numberOfInfants: numberOfInfants ?? this.numberOfInfants,
      roomType: roomType ?? this.roomType,
      travelInsurance: travelInsurance ?? this.travelInsurance,
      airportTransfer: airportTransfer ?? this.airportTransfer,
      additionalTour: additionalTour ?? this.additionalTour,
      hotelUpgrade: hotelUpgrade ?? this.hotelUpgrade,
      preferredSeats: preferredSeats ?? this.preferredSeats,
      specialRequests: specialRequests ?? this.specialRequests,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
      basePrice: basePrice ?? this.basePrice,
      insurancePrice: insurancePrice ?? this.insurancePrice,
      transferPrice: transferPrice ?? this.transferPrice,
      tourPrice: tourPrice ?? this.tourPrice,
      upgradePrice: upgradePrice ?? this.upgradePrice,
      seatsPrice: seatsPrice ?? this.seatsPrice,
      taxRate: taxRate ?? this.taxRate,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneCountryCode': phoneCountryCode,
      'phoneNumber': phoneNumber,
      'countryOfResidence': countryOfResidence,
      'birthDate': birthDate?.toIso8601String(),
      'passportNumber': passportNumber,
      'packageTitle': packageTitle,
      'departureDate': departureDate?.toIso8601String(),
      'numberOfAdults': numberOfAdults,
      'numberOfChildren': numberOfChildren,
      'numberOfInfants': numberOfInfants,
      'roomType': roomType.toString(),
      'travelInsurance': travelInsurance,
      'airportTransfer': airportTransfer,
      'additionalTour': additionalTour,
      'hotelUpgrade': hotelUpgrade,
      'preferredSeats': preferredSeats,
      'specialRequests': specialRequests,
      'basePrice': basePrice,
      'totalAmount': totalAmount,
    };
  }

  @override
  String toString() {
    return 'BookingData(name: $firstName $lastName, package: $packageTitle, travelers: $totalTravelers, total: \$${totalAmount.toStringAsFixed(2)})';
  }
}

/// Enum for room types
enum RoomType {
  single('Individual'),
  double('Doble'),
  triple('Triple');

  final String label;
  const RoomType(this.label);
}
