import 'package:by_lety_travels/data/models/coupon.dart';

/// Service to manage discount coupons
class CouponService {
  // Predefined coupons for the application
  static final List<Coupon> _availableCoupons = [
    // Percentage discounts
    Coupon(
      code: 'WELCOME10',
      description: 'Descuento de bienvenida para nuevos clientes',
      type: CouponType.percentage,
      value: 10,
      expirationDate: DateTime(2025, 12, 31),
    ),
    Coupon(
      code: 'SUMMER20',
      description: 'Promoción de verano',
      type: CouponType.percentage,
      value: 20,
      expirationDate: DateTime(2025, 9, 30),
      minPurchaseAmount: 1000,
    ),
    Coupon(
      code: 'FAMILY15',
      description: 'Descuento para viajes familiares',
      type: CouponType.percentage,
      value: 15,
      minPurchaseAmount: 2000,
    ),
    Coupon(
      code: 'VIP25',
      description: 'Cupón VIP exclusivo',
      type: CouponType.percentage,
      value: 25,
      expirationDate: DateTime(2025, 11, 30),
      minPurchaseAmount: 3000,
      maxUses: 50,
    ),

    // Fixed amount discounts
    Coupon(
      code: 'SAVE50',
      description: 'Ahorra \$50 en tu próxima reserva',
      type: CouponType.fixedAmount,
      value: 50,
      minPurchaseAmount: 500,
    ),
    Coupon(
      code: 'SAVE100',
      description: 'Ahorra \$100 en tu reserva',
      type: CouponType.fixedAmount,
      value: 100,
      expirationDate: DateTime(2025, 12, 31),
      minPurchaseAmount: 1500,
    ),
    Coupon(
      code: 'EARLYBIRD',
      description: 'Descuento por reserva anticipada',
      type: CouponType.fixedAmount,
      value: 150,
      minPurchaseAmount: 2500,
    ),

    // Special promotions
    Coupon(
      code: 'BLACKFRIDAY',
      description: 'Black Friday - ¡30% de descuento!',
      type: CouponType.percentage,
      value: 30,
      expirationDate: DateTime(2025, 11, 30),
      minPurchaseAmount: 800,
      maxUses: 100,
    ),
    Coupon(
      code: 'NEWYEAR2026',
      description: 'Año Nuevo 2026 - Celebra con descuento',
      type: CouponType.percentage,
      value: 15,
      expirationDate: DateTime(2026, 1, 15),
      minPurchaseAmount: 1200,
    ),

    // Referral and loyalty
    Coupon(
      code: 'REFERIDO',
      description: 'Descuento por referido',
      type: CouponType.fixedAmount,
      value: 75,
      minPurchaseAmount: 1000,
    ),
  ];

  /// Validate and get coupon by code
  /// Returns null if coupon doesn't exist or is invalid
  static Coupon? validateCoupon(String code, {double? purchaseAmount}) {
    if (code.isEmpty) return null;

    // Find coupon by code (case-insensitive)
    final coupon = _availableCoupons.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse:
          () => Coupon(
            code: '',
            description: '',
            type: CouponType.percentage,
            value: 0,
            isActive: false,
          ),
    );

    // Check if coupon was found
    if (coupon.code.isEmpty) return null;

    // Check if coupon is valid
    if (!coupon.isValid()) return null;

    // Check if applicable for amount (if provided)
    if (purchaseAmount != null && !coupon.isApplicableFor(purchaseAmount)) {
      return null;
    }

    return coupon;
  }

  /// Get all available active coupons
  static List<Coupon> getActiveCoupons() {
    return _availableCoupons.where((c) => c.isValid()).toList();
  }

  /// Get coupon by code without validation
  static Coupon? getCouponByCode(String code) {
    try {
      return _availableCoupons.firstWhere(
        (c) => c.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get popular/recommended coupons
  static List<Coupon> getRecommendedCoupons({int limit = 3}) {
    final activeCoupons = getActiveCoupons();
    activeCoupons.sort((a, b) {
      // Sort by value (higher discounts first)
      if (a.type == CouponType.percentage && b.type == CouponType.percentage) {
        return b.value.compareTo(a.value);
      }
      return 0;
    });
    return activeCoupons.take(limit).toList();
  }
}
