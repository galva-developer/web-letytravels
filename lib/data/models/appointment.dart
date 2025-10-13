/// Modelo para citas de asesoría
class Appointment {
  final String id;
  final DateTime date;
  final String timeSlot; // e.g., "09:00 AM"
  final AppointmentType type;
  final String clientName;
  final String clientEmail;
  final String? clientPhone;
  final String? notes;
  final AppointmentStatus status;
  final DateTime createdAt;

  Appointment({
    String? id,
    required this.date,
    required this.timeSlot,
    required this.type,
    required this.clientName,
    required this.clientEmail,
    this.clientPhone,
    this.notes,
    this.status = AppointmentStatus.pending,
    DateTime? createdAt,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
       createdAt = createdAt ?? DateTime.now();

  /// Validar que los campos obligatorios estén completos
  bool isValid() {
    return clientName.trim().isNotEmpty &&
        clientEmail.trim().isNotEmpty &&
        _isValidEmail(clientEmail);
  }

  /// Validar formato de email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Obtener fecha y hora en formato legible
  String get formattedDateTime {
    final months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    final day = date.day;
    final month = months[date.month - 1];
    final year = date.year;
    return '$day de $month de $year - $timeSlot';
  }

  /// Obtener razón por la cual la cita no es válida
  String? getInvalidReason() {
    if (clientName.trim().isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (clientEmail.trim().isEmpty) {
      return 'El email es obligatorio';
    }
    if (!_isValidEmail(clientEmail)) {
      return 'El email no tiene un formato válido';
    }
    return null;
  }

  /// Verificar si la cita está en el futuro
  bool isFuture() {
    final now = DateTime.now();
    return date.isAfter(now) ||
        (date.year == now.year &&
            date.month == now.month &&
            date.day == now.day);
  }

  /// Verificar si la cita se puede cancelar (al menos 24 horas antes)
  bool canBeCanceled() {
    final now = DateTime.now();
    final difference = date.difference(now);
    return difference.inHours >= 24 && status != AppointmentStatus.canceled;
  }

  /// Convertir a Map para almacenamiento
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
      'type': type.toString().split('.').last,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'notes': notes,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Crear desde Map
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      date: DateTime.parse(map['date']),
      timeSlot: map['timeSlot'],
      type: AppointmentType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => AppointmentType.video,
      ),
      clientName: map['clientName'],
      clientEmail: map['clientEmail'],
      clientPhone: map['clientPhone'],
      notes: map['notes'],
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  /// Crear copia con modificaciones
  Appointment copyWith({
    String? id,
    DateTime? date,
    String? timeSlot,
    AppointmentType? type,
    String? clientName,
    String? clientEmail,
    String? clientPhone,
    String? notes,
    AppointmentStatus? status,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      type: type ?? this.type,
      clientName: clientName ?? this.clientName,
      clientEmail: clientEmail ?? this.clientEmail,
      clientPhone: clientPhone ?? this.clientPhone,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Appointment(id: $id, date: $formattedDateTime, type: ${type.displayName}, client: $clientName)';
  }
}

/// Tipos de asesoría
enum AppointmentType {
  inPerson, // Presencial
  video, // Video llamada
  phone, // Teléfono
}

/// Estados de la cita
enum AppointmentStatus {
  pending, // Pendiente de confirmación
  confirmed, // Confirmada
  completed, // Completada
  canceled, // Cancelada
  noShow, // Cliente no se presentó
}

/// Extensión para obtener nombres amigables de los tipos de cita
extension AppointmentTypeExtension on AppointmentType {
  String get displayName {
    switch (this) {
      case AppointmentType.inPerson:
        return 'Presencial';
      case AppointmentType.video:
        return 'Video Llamada';
      case AppointmentType.phone:
        return 'Teléfono';
    }
  }

  String get icon {
    switch (this) {
      case AppointmentType.inPerson:
        return '🏢';
      case AppointmentType.video:
        return '📹';
      case AppointmentType.phone:
        return '📞';
    }
  }

  String get description {
    switch (this) {
      case AppointmentType.inPerson:
        return 'Reunión en nuestras oficinas';
      case AppointmentType.video:
        return 'Video llamada por Zoom/Meet';
      case AppointmentType.phone:
        return 'Llamada telefónica';
    }
  }
}

/// Extensión para obtener nombres amigables de los estados
extension AppointmentStatusExtension on AppointmentStatus {
  String get displayName {
    switch (this) {
      case AppointmentStatus.pending:
        return 'Pendiente';
      case AppointmentStatus.confirmed:
        return 'Confirmada';
      case AppointmentStatus.completed:
        return 'Completada';
      case AppointmentStatus.canceled:
        return 'Cancelada';
      case AppointmentStatus.noShow:
        return 'No asistió';
    }
  }
}
