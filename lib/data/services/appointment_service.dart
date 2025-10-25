import 'package:by_lety_travels/data/models/appointment.dart';
import 'package:by_lety_travels/data/models/time_slot.dart';
import 'package:by_lety_travels/data/services/email_service.dart';

/// Servicio para gestión de citas de asesoría
class AppointmentService {
  // Almacenamiento simulado de citas (en producción usar Firebase/Supabase)
  static final List<Appointment> _appointments = [];

  /// Obtener todas las citas
  static Future<List<Appointment>> getAppointments() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_appointments);
  }

  /// Obtener citas por fecha
  static Future<List<Appointment>> getAppointmentsByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _appointments.where((appointment) {
      return appointment.date.year == date.year &&
          appointment.date.month == date.month &&
          appointment.date.day == date.day;
    }).toList();
  }

  /// Obtener slots ocupados para una fecha
  static Future<List<String>> getBookedSlots(DateTime date) async {
    final appointments = await getAppointmentsByDate(date);
    return appointments
        .where(
          (app) =>
              app.status != AppointmentStatus.canceled &&
              app.status != AppointmentStatus.noShow,
        )
        .map((app) => app.timeSlot)
        .toList();
  }

  /// Obtener slots disponibles para una fecha
  static Future<List<TimeSlot>> getAvailableSlots(DateTime date) async {
    final bookedSlots = await getBookedSlots(date);
    return TimeSlotGenerator.generateDailySlots(date, bookedSlots: bookedSlots);
  }

  /// Verificar si un slot específico está disponible
  static Future<bool> isSlotAvailable(DateTime date, String timeSlot) async {
    final bookedSlots = await getBookedSlots(date);
    final slot = TimeSlotGenerator.generateDailySlots(
      date,
      bookedSlots: bookedSlots,
    ).firstWhere(
      (s) => s.time == timeSlot,
      orElse: () => TimeSlot.fromTime(0, 0, isAvailable: false),
    );
    return slot.isAvailable;
  }

  /// Crear una nueva cita
  static Future<bool> bookAppointment(Appointment appointment) async {
    try {
      // Validar la cita
      if (!appointment.isValid()) {
        throw Exception(appointment.getInvalidReason());
      }

      // Verificar que la cita sea en el futuro
      if (!appointment.isFuture()) {
        throw Exception('La cita debe ser en una fecha futura');
      }

      // Verificar disponibilidad del slot
      final isAvailable = await isSlotAvailable(
        appointment.date,
        appointment.timeSlot,
      );
      if (!isAvailable) {
        throw Exception('El horario seleccionado ya no está disponible');
      }

      // Simular delay de creación
      await Future.delayed(const Duration(seconds: 1));

      // Agregar la cita
      _appointments.add(appointment);

      print('📅 Cita creada exitosamente:');
      print(appointment.toMap());

      // Enviar emails de confirmación
      print('📧 Enviando correos de confirmación...');
      final emailResults = await EmailService.sendAppointmentEmails(
        appointment: appointment,
      );

      if (emailResults['client'] == true) {
        print('✅ Email de confirmación enviado al cliente');
      } else {
        print('⚠️ No se pudo enviar el email al cliente');
      }

      if (emailResults['business'] == true) {
        print('✅ Email de notificación enviado al negocio');
      } else {
        print('⚠️ No se pudo enviar el email al negocio');
      }

      return true;
    } catch (e) {
      print('❌ Error al crear cita: $e');
      return false;
    }
  }

  /// Actualizar estado de una cita
  static Future<bool> updateAppointmentStatus(
    String appointmentId,
    AppointmentStatus newStatus,
  ) async {
    try {
      final index = _appointments.indexWhere((app) => app.id == appointmentId);
      if (index == -1) {
        throw Exception('Cita no encontrada');
      }

      _appointments[index] = _appointments[index].copyWith(status: newStatus);

      await Future.delayed(const Duration(milliseconds: 500));

      print(
        '✅ Cita actualizada: ${_appointments[index].id} -> ${newStatus.displayName}',
      );
      return true;
    } catch (e) {
      print('❌ Error al actualizar cita: $e');
      return false;
    }
  }

  /// Cancelar una cita
  static Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final appointment = _appointments.firstWhere(
        (app) => app.id == appointmentId,
      );

      if (!appointment.canBeCanceled()) {
        throw Exception(
          'No se puede cancelar una cita con menos de 24 horas de anticipación',
        );
      }

      return await updateAppointmentStatus(
        appointmentId,
        AppointmentStatus.canceled,
      );
    } catch (e) {
      print('❌ Error al cancelar cita: $e');
      return false;
    }
  }

  /// Confirmar una cita
  static Future<bool> confirmAppointment(String appointmentId) async {
    return await updateAppointmentStatus(
      appointmentId,
      AppointmentStatus.confirmed,
    );
  }

  /// Obtener citas pendientes
  static Future<List<Appointment>> getPendingAppointments() async {
    final all = await getAppointments();
    return all
        .where(
          (app) => app.status == AppointmentStatus.pending && app.isFuture(),
        )
        .toList();
  }

  /// Obtener citas confirmadas
  static Future<List<Appointment>> getConfirmedAppointments() async {
    final all = await getAppointments();
    return all
        .where(
          (app) => app.status == AppointmentStatus.confirmed && app.isFuture(),
        )
        .toList();
  }

  /// Obtener próximas citas (próximos 7 días)
  static Future<List<Appointment>> getUpcomingAppointments() async {
    final all = await getAppointments();
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));

    return all
        .where(
          (app) =>
              app.isFuture() &&
              app.date.isBefore(nextWeek) &&
              app.status != AppointmentStatus.canceled,
        )
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  /// Verificar si un día tiene citas disponibles
  static Future<bool> hasSlotsAvailable(DateTime date) async {
    final bookedSlots = await getBookedSlots(date);
    return TimeSlotGenerator.hasAvailableSlots(date, bookedSlots: bookedSlots);
  }

  /// Obtener próximo slot disponible
  static Future<DateTime?> getNextAvailableDate() async {
    final now = DateTime.now();
    DateTime currentDate = now;

    for (int i = 0; i < 60; i++) {
      // Buscar hasta 60 días
      if (await hasSlotsAvailable(currentDate)) {
        return currentDate;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return null;
  }

  /// Obtener estadísticas de citas
  static Future<Map<String, int>> getStatistics() async {
    final all = await getAppointments();
    return {
      'total': all.length,
      'pending': all.where((a) => a.status == AppointmentStatus.pending).length,
      'confirmed':
          all.where((a) => a.status == AppointmentStatus.confirmed).length,
      'completed':
          all.where((a) => a.status == AppointmentStatus.completed).length,
      'canceled':
          all.where((a) => a.status == AppointmentStatus.canceled).length,
      'inPerson': all.where((a) => a.type == AppointmentType.inPerson).length,
      'video': all.where((a) => a.type == AppointmentType.video).length,
      'phone': all.where((a) => a.type == AppointmentType.phone).length,
    };
  }

  /// Limpiar todas las citas (solo para desarrollo)
  static void clearAllAppointments() {
    _appointments.clear();
    print('🗑️ Todas las citas han sido eliminadas');
  }

  /// Agregar citas de ejemplo (solo para desarrollo/testing)
  static Future<void> addSampleAppointments() async {
    final now = DateTime.now();

    final samples = [
      Appointment(
        date: now.add(const Duration(days: 2)),
        timeSlot: '10:00 AM',
        type: AppointmentType.video,
        clientName: 'Juan Pérez',
        clientEmail: 'juan@example.com',
        clientPhone: '+51 999 888 777',
        status: AppointmentStatus.confirmed,
      ),
      Appointment(
        date: now.add(const Duration(days: 3)),
        timeSlot: '02:00 PM',
        type: AppointmentType.inPerson,
        clientName: 'María García',
        clientEmail: 'maria@example.com',
        status: AppointmentStatus.pending,
      ),
      Appointment(
        date: now.add(const Duration(days: 5)),
        timeSlot: '11:30 AM',
        type: AppointmentType.phone,
        clientName: 'Carlos López',
        clientEmail: 'carlos@example.com',
        clientPhone: '+51 988 777 666',
        notes: 'Interesado en paquetes a Europa',
        status: AppointmentStatus.confirmed,
      ),
    ];

    _appointments.addAll(samples);
    print('✅ ${samples.length} citas de ejemplo agregadas');
  }
}
