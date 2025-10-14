import 'package:by_lety_travels/data/models/coupon.dart';

/// Service to manage discount coupons
class CouponService {
  // Predefined coupons for the application
  static final List<Coupon> _availableCoupons = [
    // Percentage discounts
    Coupon(
      code: 'WELCOME10',
      description: 'Descuento de bienvenida - 10% OFF',
      type: CouponType.percentage,
      value: 10,
      expirationDate: DateTime(2025, 12, 31),
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
