import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:by_lety_travels/data/models/booking_data.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';

/// Service to send booking confirmation emails using EmailJS
///
/// EmailJS Setup Required:
/// 1. Create account at https://www.emailjs.com/
/// 2. Add email service (Gmail, etc.)
/// 3. Create email templates
/// 4. Get your Service ID, Template ID, and Public Key
class EmailService {
  // TODO: Replace these with your actual EmailJS credentials
  // Get them from https://dashboard.emailjs.com/
  static const String _serviceId = 'YOUR_SERVICE_ID';
  static const String _templateIdClient = 'YOUR_TEMPLATE_ID_CLIENT';
  static const String _templateIdBusiness = 'YOUR_TEMPLATE_ID_BUSINESS';
  static const String _publicKey = 'YOUR_PUBLIC_KEY';
  static const String _emailJsUrl =
      'https://api.emailjs.com/api/v1.0/email/send';

  /// Send booking confirmation email to client
  static Future<bool> sendClientConfirmationEmail({
    required String bookingNumber,
    required BookingData bookingData,
    required PackageTravel package,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_emailJsUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateIdClient,
          'user_id': _publicKey,
          'template_params': {
            'to_email': bookingData.email,
            'to_name': '${bookingData.firstName} ${bookingData.lastName}',
            'booking_number': bookingNumber,
            'package_name': package.title,
            'package_location': package.location,
            'package_duration': package.duration,
            'departure_date':
                bookingData.departureDate != null
                    ? '${bookingData.departureDate!.day}/${bookingData.departureDate!.month}/${bookingData.departureDate!.year}'
                    : 'Por confirmar',
            'travelers': '${bookingData.totalTravelers}',
            'total_amount': '\$${bookingData.totalAmount.toStringAsFixed(2)}',
            'customer_email': bookingData.email,
            'customer_phone':
                '${bookingData.phoneCountryCode} ${bookingData.phoneNumber}',
          },
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error sending client email: $e');
      return false;
    }
  }

  /// Send booking notification email to business
  static Future<bool> sendBusinessNotificationEmail({
    required String bookingNumber,
    required BookingData bookingData,
    required PackageTravel package,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_emailJsUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateIdBusiness,
          'user_id': _publicKey,
          'template_params': {
            'to_email': 'byletytravels.oficial@gmail.com',
            'booking_number': bookingNumber,
            'customer_name': '${bookingData.firstName} ${bookingData.lastName}',
            'customer_email': bookingData.email,
            'customer_phone':
                '${bookingData.phoneCountryCode} ${bookingData.phoneNumber}',
            'customer_country': bookingData.countryOfResidence,
            'package_name': package.title,
            'package_location': package.location,
            'package_duration': package.duration,
            'departure_date':
                bookingData.departureDate != null
                    ? '${bookingData.departureDate!.day}/${bookingData.departureDate!.month}/${bookingData.departureDate!.year}'
                    : 'Por confirmar',
            'room_type': bookingData.roomType.label,
            'adults': '${bookingData.numberOfAdults}',
            'children': '${bookingData.numberOfChildren}',
            'infants': '${bookingData.numberOfInfants}',
            'total_travelers': '${bookingData.totalTravelers}',
            'base_price': '\$${bookingData.basePrice.toStringAsFixed(2)}',
            'discount':
                bookingData.appliedCoupon != null
                    ? '\$${bookingData.discountAmount.toStringAsFixed(2)} (${bookingData.appliedCoupon!.code})'
                    : 'N/A',
            'total_amount': '\$${bookingData.totalAmount.toStringAsFixed(2)}',
            'special_requests': bookingData.specialRequests ?? 'Ninguna',
          },
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error sending business email: $e');
      return false;
    }
  }

  /// Send both emails (client and business)
  static Future<Map<String, bool>> sendBookingEmails({
    required String bookingNumber,
    required BookingData bookingData,
    required PackageTravel package,
  }) async {
    final clientEmailSent = await sendClientConfirmationEmail(
      bookingNumber: bookingNumber,
      bookingData: bookingData,
      package: package,
    );

    final businessEmailSent = await sendBusinessNotificationEmail(
      bookingNumber: bookingNumber,
      bookingData: bookingData,
      package: package,
    );

    return {'client': clientEmailSent, 'business': businessEmailSent};
  }
}
