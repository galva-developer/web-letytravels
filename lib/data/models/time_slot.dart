/// Modelo para slots de tiempo disponibles
class TimeSlot {
  final String time; // e.g., "09:00 AM"
  final bool isAvailable;
  final int hour; // 0-23
  final int minute; // 0-59

  TimeSlot({
    required this.time,
    this.isAvailable = true,
    required this.hour,
    required this.minute,
  });

  /// Crear TimeSlot desde hora y minuto
  factory TimeSlot.fromTime(int hour, int minute, {bool isAvailable = true}) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final timeString =
        '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    return TimeSlot(
      time: timeString,
      hour: hour,
      minute: minute,
      isAvailable: isAvailable,
    );
  }

  /// Verificar si el slot está en el pasado
  bool isPast(DateTime date) {
    final now = DateTime.now();
    final slotDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );
    return slotDateTime.isBefore(now);
  }

  /// Crear copia con disponibilidad modificada
  TimeSlot copyWith({bool? isAvailable}) {
    return TimeSlot(
      time: time,
      hour: hour,
      minute: minute,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  String toString() => 'TimeSlot($time, available: $isAvailable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimeSlot &&
        other.time == time &&
        other.hour == hour &&
        other.minute == minute;
  }

  @override
  int get hashCode => time.hashCode ^ hour.hashCode ^ minute.hashCode;
}

/// Generador de slots de tiempo para un día
class TimeSlotGenerator {
  /// Generar slots de 30 minutos para un día laboral
  /// Horario por defecto: 9:00 AM - 7:00 PM
  /// Excepto sábados: 9:00 AM - 2:00 PM
  static List<TimeSlot> generateDailySlots(
    DateTime date, {
    List<String>? bookedSlots,
  }) {
    final slots = <TimeSlot>[];
    final weekday = date.weekday;

    // Domingo (7) - No hay atención
    if (weekday == DateTime.sunday) {
      return slots;
    }

    int startHour = 9; // 9:00 AM
    int endHour =
        weekday == DateTime.saturday ? 14 : 19; // Sáb: 2 PM, L-V: 7 PM

    for (int hour = startHour; hour < endHour; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        final slot = TimeSlot.fromTime(hour, minute);

        // Verificar si el slot está reservado
        final isBooked = bookedSlots?.contains(slot.time) ?? false;

        // Verificar si el slot está en el pasado
        final isPast = slot.isPast(date);

        slots.add(slot.copyWith(isAvailable: !isBooked && !isPast));
      }
    }

    return slots;
  }

  /// Obtener slots solo de la mañana (9:00 AM - 12:00 PM)
  static List<TimeSlot> getMorningSlots(List<TimeSlot> allSlots) {
    return allSlots.where((slot) => slot.hour < 12).toList();
  }

  /// Obtener slots solo de la tarde (12:00 PM - 7:00 PM)
  static List<TimeSlot> getAfternoonSlots(List<TimeSlot> allSlots) {
    return allSlots.where((slot) => slot.hour >= 12).toList();
  }

  /// Verificar si un día tiene slots disponibles
  static bool hasAvailableSlots(DateTime date, {List<String>? bookedSlots}) {
    final slots = generateDailySlots(date, bookedSlots: bookedSlots);
    return slots.any((slot) => slot.isAvailable);
  }

  /// Obtener próximo slot disponible desde una fecha
  static TimeSlot? getNextAvailableSlot(
    DateTime fromDate, {
    List<String>? bookedSlots,
  }) {
    DateTime currentDate = fromDate;
    final maxDays = 60; // Buscar hasta 60 días en el futuro

    for (int i = 0; i < maxDays; i++) {
      final slots = generateDailySlots(currentDate, bookedSlots: bookedSlots);
      final availableSlot = slots.firstWhere(
        (slot) => slot.isAvailable,
        orElse: () => TimeSlot.fromTime(0, 0, isAvailable: false),
      );

      if (availableSlot.isAvailable) {
        return availableSlot;
      }

      currentDate = currentDate.add(const Duration(days: 1));
    }

    return null;
  }
}
