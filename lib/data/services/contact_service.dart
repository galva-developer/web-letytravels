import 'package:by_lety_travels/data/models/contact_inquiry.dart';

/// Servicio para gestionar consultas y contactos
class ContactService {
  // Información de contacto de la agencia
  static const String phoneNumber = '+51 984 102 859';
  static const String whatsappNumber = '51984102859'; // Sin espacios ni +
  static const String email = 'info@byletytravels.com';
  static const String emergencyPhone = '+51 984 102 859';

  // Horarios de atención
  static const Map<String, String> businessHours = {
    'Lunes a Viernes': '9:00 AM - 7:00 PM',
    'Sábados': '9:00 AM - 2:00 PM',
    'Domingos': 'Cerrado',
  };

  /// Verificar si la agencia está abierta en este momento
  static bool isOpenNow() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final weekday = now.weekday;

    // Lunes a Viernes (1-5): 9:00 AM - 7:00 PM
    if (weekday >= 1 && weekday <= 5) {
      return (hour > 9 || (hour == 9 && minute >= 0)) &&
          (hour < 19 || (hour == 19 && minute == 0));
    }

    // Sábados (6): 9:00 AM - 2:00 PM
    if (weekday == 6) {
      return (hour > 9 || (hour == 9 && minute >= 0)) &&
          (hour < 14 || (hour == 14 && minute == 0));
    }

    // Domingos (7): Cerrado
    return false;
  }

  /// Obtener el horario actual como texto
  static String getCurrentBusinessHoursText() {
    final now = DateTime.now();
    final weekday = now.weekday;

    if (weekday >= 1 && weekday <= 5) {
      return businessHours['Lunes a Viernes']!;
    } else if (weekday == 6) {
      return businessHours['Sábados']!;
    } else {
      return businessHours['Domingos']!;
    }
  }

  /// Obtener el estado de disponibilidad como texto
  static String getAvailabilityStatus() {
    if (isOpenNow()) {
      return 'En línea';
    } else {
      return 'Fuera de horario';
    }
  }

  /// Generar mensaje predefinido para WhatsApp
  static String getWhatsAppMessage({String? packageName}) {
    if (packageName != null) {
      return 'Hola, me interesa obtener información sobre el paquete "$packageName".';
    }
    return 'Hola, me interesa información sobre los paquetes de viaje de ByLetyTravels.';
  }

  /// Obtener URL de WhatsApp con mensaje predefinido
  static String getWhatsAppUrl({String? packageName}) {
    final message = Uri.encodeComponent(
      getWhatsAppMessage(packageName: packageName),
    );
    return 'https://wa.me/$whatsappNumber?text=$message';
  }

  /// Obtener URL de llamada telefónica
  static String getPhoneCallUrl() {
    return 'tel:$phoneNumber';
  }

  /// Obtener URL de email
  static String getEmailUrl({String? subject, String? body}) {
    final subjectEncoded = subject != null ? Uri.encodeComponent(subject) : '';
    final bodyEncoded = body != null ? Uri.encodeComponent(body) : '';

    String url = 'mailto:$email';
    if (subjectEncoded.isNotEmpty || bodyEncoded.isNotEmpty) {
      url += '?';
      if (subjectEncoded.isNotEmpty) {
        url += 'subject=$subjectEncoded';
      }
      if (bodyEncoded.isNotEmpty) {
        if (subjectEncoded.isNotEmpty) url += '&';
        url += 'body=$bodyEncoded';
      }
    }
    return url;
  }

  /// Enviar consulta rápida (simulado - en producción conectar con backend/email service)
  static Future<bool> sendInquiry(ContactInquiry inquiry) async {
    try {
      // Validar la consulta
      if (!inquiry.isValid()) {
        throw Exception(inquiry.getInvalidReason());
      }

      // Simular delay de envío
      await Future.delayed(const Duration(seconds: 2));

      // En producción, aquí se enviaría a:
      // - Backend API
      // - Firebase Firestore
      // - Email service (SendGrid, Mailgun)
      // - WhatsApp Business API

      print('📧 Consulta enviada exitosamente:');
      print(inquiry.toMap());

      // Simular éxito
      return true;
    } catch (e) {
      print('❌ Error al enviar consulta: $e');
      return false;
    }
  }

  /// Obtener consultas guardadas (simulado)
  static Future<List<ContactInquiry>> getInquiries() async {
    // En producción, obtener desde backend o Firebase
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  /// Validar formato de email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validar formato de teléfono (básico)
  static bool isValidPhone(String phone) {
    // Eliminar espacios, guiones y paréntesis
    final cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    // Verificar que tenga entre 7 y 15 dígitos
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(cleaned);
  }

  /// Obtener horarios formateados como lista
  static List<Map<String, String>> getBusinessHoursList() {
    return businessHours.entries.map((entry) {
      return {'day': entry.key, 'hours': entry.value};
    }).toList();
  }

  /// Obtener próximo horario de apertura
  static String getNextOpeningTime() {
    final now = DateTime.now();
    final weekday = now.weekday;
    final hour = now.hour;

    // Si es fin de semana después de cerrar, siguiente apertura es el lunes
    if (weekday == 6 && hour >= 14) {
      return 'Lunes 9:00 AM';
    }
    if (weekday == 7) {
      return 'Lunes 9:00 AM';
    }

    // Si es entre semana después de cerrar, siguiente apertura es mañana
    if (weekday >= 1 && weekday <= 5 && hour >= 19) {
      return 'Mañana 9:00 AM';
    }

    // Si es viernes después de cerrar, siguiente apertura es el sábado
    if (weekday == 5 && hour >= 19) {
      return 'Sábado 9:00 AM';
    }

    return 'Próximamente';
  }

  /// Obtener información de contacto completa
  static Map<String, dynamic> getContactInfo() {
    return {
      'phone': phoneNumber,
      'whatsapp': whatsappNumber,
      'email': email,
      'emergencyPhone': emergencyPhone,
      'businessHours': businessHours,
      'isOpen': isOpenNow(),
      'status': getAvailabilityStatus(),
      'currentHours': getCurrentBusinessHoursText(),
      'nextOpening': getNextOpeningTime(),
    };
  }
}
