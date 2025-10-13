import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/services/appointment_service.dart';

/// Calendario interactivo para seleccionar fecha de cita
class AppointmentCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const AppointmentCalendar({
    super.key,
    this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;
  Map<String, bool> _availabilityCache = {};

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialDate ?? DateTime.now();
    _selectedDate = widget.initialDate;
    _loadAvailability();
  }

  Future<void> _loadAvailability() async {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    for (
      var date = firstDay;
      date.isBefore(lastDay.add(const Duration(days: 1)));
      date = date.add(const Duration(days: 1))
    ) {
      final key = '${date.year}-${date.month}-${date.day}';
      final hasSlots = await AppointmentService.hasSlotsAvailable(date);
      if (mounted) {
        setState(() {
          _availabilityCache[key] = hasSlots;
        });
      }
    }
  }

  bool _isDateAvailable(DateTime date) {
    // No permitir fechas pasadas
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return false;
    }

    // No atención los domingos
    if (date.weekday == DateTime.sunday) {
      return false;
    }

    final key = '${date.year}-${date.month}-${date.day}';
    return _availabilityCache[key] ?? true;
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      _availabilityCache.clear();
    });
    _loadAvailability();
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      _availabilityCache.clear();
    });
    _loadAvailability();
  }

  void _selectDate(DateTime date) {
    if (_isDateAvailable(date)) {
      setState(() {
        _selectedDate = date;
      });
      widget.onDateSelected(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildWeekdays(),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
          const SizedBox(height: 12),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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

    final monthName = months[_currentMonth.month - 1];
    final year = _currentMonth.year;

    // No permitir retroceder más allá del mes actual
    final now = DateTime.now();
    final canGoPrevious = _currentMonth.isAfter(DateTime(now.year, now.month));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: canGoPrevious ? _previousMonth : null,
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Mes anterior',
        ),
        Text(
          '$monthName $year',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: _nextMonth,
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Mes siguiente',
        ),
      ],
    );
  }

  Widget _buildWeekdays() {
    const weekdays = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:
          weekdays.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    // Calcular el primer día de la semana (L=1, D=7)
    int firstWeekday = firstDayOfMonth.weekday;
    int daysInMonth = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];

    // Agregar espacios vacíos antes del primer día
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Agregar los días del mes
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      dayWidgets.add(_buildDayCell(date));
    }

    // Organizar en filas de 7 días
    List<Widget> rows = [];
    for (int i = 0; i < dayWidgets.length; i += 7) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              dayWidgets.skip(i).take(7).map((widget) {
                return Expanded(child: widget);
              }).toList(),
        ),
      );
      if (i + 7 < dayWidgets.length) {
        rows.add(const SizedBox(height: 4));
      }
    }

    return Column(children: rows);
  }

  Widget _buildDayCell(DateTime date) {
    final isAvailable = _isDateAvailable(date);
    final isSelected =
        _selectedDate != null &&
        _selectedDate!.year == date.year &&
        _selectedDate!.month == date.month &&
        _selectedDate!.day == date.day;
    final isToday =
        DateTime.now().year == date.year &&
        DateTime.now().month == date.month &&
        DateTime.now().day == date.day;

    Color? backgroundColor;
    Color textColor = Colors.black87;
    Border? border;

    if (isSelected) {
      backgroundColor = Colors.blue[700];
      textColor = Colors.white;
    } else if (isToday) {
      border = Border.all(color: Colors.blue[700]!, width: 2);
    }

    if (!isAvailable) {
      backgroundColor = Colors.grey[200];
      textColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: isAvailable ? () => _selectDate(date) : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: border,
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.blue[700]!, 'Seleccionado'),
        const SizedBox(width: 16),
        _buildLegendItem(
          Colors.grey[200]!,
          'No disponible',
          textColor: Colors.grey[600],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label, {Color? textColor}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: textColor ?? Colors.black54),
        ),
      ],
    );
  }
}
