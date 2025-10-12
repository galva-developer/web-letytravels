/// Model for discount coupons
class Coupon {
  final String code;
  final String description;
  final CouponType type;
  final double value; // Percentage (0-100) or fixed amount
  final DateTime? expirationDate;
  final double? minPurchaseAmount;
  final int? maxUses;
  final int currentUses;
  final bool isActive;

  const Coupon({
    required this.code,
    required this.description,
    required this.type,
    required this.value,
    this.expirationDate,
    this.minPurchaseAmount,
    this.maxUses,
    this.currentUses = 0,
    this.isActive = true,
  });

  /// Check if coupon is valid
  bool isValid() {
    if (!isActive) return false;

    // Check expiration
    if (expirationDate != null && DateTime.now().isAfter(expirationDate!)) {
      return false;
    }

    // Check max uses
    if (maxUses != null && currentUses >= maxUses!) {
      return false;
    }

    return true;
  }

  /// Check if coupon is applicable for given amount
  bool isApplicableFor(double amount) {
    if (!isValid()) return false;

    // Check minimum purchase amount
    if (minPurchaseAmount != null && amount < minPurchaseAmount!) {
      return false;
    }

    return true;
  }

  /// Calculate discount amount for given total
  double calculateDiscount(double totalAmount) {
    if (!isApplicableFor(totalAmount)) return 0;

    switch (type) {
      case CouponType.percentage:
        // Cap at 100%
        final percentage = value.clamp(0, 100);
        return totalAmount * (percentage / 100);

      case CouponType.fixedAmount:
        // Don't exceed total amount
        return value.clamp(0, totalAmount);
    }
  }

  /// Get reason why coupon is invalid
  String? getInvalidReason(double? amount) {
    if (!isActive) {
      return 'Este cupón no está activo';
    }

    if (expirationDate != null && DateTime.now().isAfter(expirationDate!)) {
      return 'Este cupón ha expirado';
    }

    if (maxUses != null && currentUses >= maxUses!) {
      return 'Este cupón ha alcanzado su límite de usos';
    }

    if (amount != null &&
        minPurchaseAmount != null &&
        amount < minPurchaseAmount!) {
      return 'Compra mínima de \$${minPurchaseAmount!.toStringAsFixed(0)} requerida';
    }

    return null;
  }

  /// Format discount display
  String getDiscountDisplay() {
    switch (type) {
      case CouponType.percentage:
        return '${value.toStringAsFixed(0)}% OFF';
      case CouponType.fixedAmount:
        return '\$${value.toStringAsFixed(0)} OFF';
    }
  }

  @override
  String toString() {
    return 'Coupon(code: $code, ${getDiscountDisplay()}, expires: ${expirationDate ?? "never"})';
  }
}

/// Enum for coupon discount types
enum CouponType { percentage, fixedAmount }
