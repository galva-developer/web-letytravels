/// Modelo para consultas de contacto rápido
class ContactInquiry {
  final String name;
  final String email;
  final String? phone;
  final String message;
  final DateTime timestamp;
  final InquiryType type;
  final String? subject;

  ContactInquiry({
    required this.name,
    required this.email,
    this.phone,
    required this.message,
    DateTime? timestamp,
    this.type = InquiryType.general,
    this.subject,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Validar que los campos obligatorios estén completos
  bool isValid() {
    return name.trim().isNotEmpty &&
        email.trim().isNotEmpty &&
        _isValidEmail(email) &&
        message.trim().isNotEmpty &&
        message.trim().length >= 10;
  }

  /// Validar formato de email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Obtener razón por la cual la consulta no es válida
  String? getInvalidReason() {
    if (name.trim().isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (email.trim().isEmpty) {
      return 'El email es obligatorio';
    }
    if (!_isValidEmail(email)) {
      return 'El email no tiene un formato válido';
    }
    if (message.trim().isEmpty) {
      return 'El mensaje es obligatorio';
    }
    if (message.trim().length < 10) {
      return 'El mensaje debe tener al menos 10 caracteres';
    }
    return null;
  }

  /// Convertir a Map para envío
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString().split('.').last,
      'subject': subject,
    };
  }

  /// Crear desde Map
  factory ContactInquiry.fromMap(Map<String, dynamic> map) {
    return ContactInquiry(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      message: map['message'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
      type: InquiryType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => InquiryType.general,
      ),
      subject: map['subject'],
    );
  }

  /// Crear copia con modificaciones
  ContactInquiry copyWith({
    String? name,
    String? email,
    String? phone,
    String? message,
    DateTime? timestamp,
    InquiryType? type,
    String? subject,
  }) {
    return ContactInquiry(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      subject: subject ?? this.subject,
    );
  }

  @override
  String toString() {
    return 'ContactInquiry(name: $name, email: $email, type: $type, timestamp: $timestamp)';
  }
}

/// Tipos de consulta
enum InquiryType {
  general, // Consulta general
  packageInfo, // Información sobre paquetes
  booking, // Consulta sobre reserva
  modification, // Modificación de reserva
  cancellation, // Cancelación
  complaint, // Queja o sugerencia
  payment, // Consulta sobre pagos
  other, // Otros
}

/// Extensión para obtener nombres amigables de los tipos
extension InquiryTypeExtension on InquiryType {
  String get displayName {
    switch (this) {
      case InquiryType.general:
        return 'Consulta General';
      case InquiryType.packageInfo:
        return 'Información sobre Paquetes';
      case InquiryType.booking:
        return 'Consulta sobre Reserva';
      case InquiryType.modification:
        return 'Modificar Reserva';
      case InquiryType.cancellation:
        return 'Cancelación';
      case InquiryType.complaint:
        return 'Quejas y Sugerencias';
      case InquiryType.payment:
        return 'Consulta sobre Pagos';
      case InquiryType.other:
        return 'Otros';
    }
  }
}
