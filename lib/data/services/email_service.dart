import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:by_lety_travels/data/models/booking_data.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/config/email_config.dart';

/// Service to send booking confirmation emails using EmailJS
///
/// ⚠️ IMPORTANTE: Las credenciales de EmailJS están en lib/config/email_config.dart
/// Ese archivo NO se sube al repositorio (está en .gitignore)
///
/// Para configurar:
/// 1. Lee README_EMAIL_SETUP.md
/// 2. Crea una cuenta en https://www.emailjs.com/
/// 3. Configura tus credenciales en lib/config/email_config.dart
class EmailService {
  // Credenciales importadas desde archivo de configuración seguro
  static final String _serviceId = EmailConfig.serviceId;
  static final String _templateIdClient = EmailConfig.templateIdClient;
  static final String _templateIdBusiness = EmailConfig.templateIdBusiness;
  static final String _publicKey = EmailConfig.publicKey;
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
