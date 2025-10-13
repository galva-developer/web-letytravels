import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/time_slot.dart';
import 'package:by_lety_travels/data/services/appointment_service.dart';

/// Selector de horarios disponibles para una fecha
class AppointmentTimePicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(String) onTimeSelected;
  final String? initialTime;

  const AppointmentTimePicker({
    super.key,
    required this.selectedDate,
    required this.onTimeSelected,
    this.initialTime,
  });

  @override
  State<AppointmentTimePicker> createState() => _AppointmentTimePickerState();
}

class _AppointmentTimePickerState extends State<AppointmentTimePicker> {
  List<TimeSlot> _allSlots = [];
  String? _selectedTime;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _loadSlots();
  }

  @override
  void didUpdateWidget(AppointmentTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _selectedTime = null;
      _loadSlots();
    }
  }

  Future<void> _loadSlots() async {
    setState(() {
      _isLoading = true;
    });

    final slots = await AppointmentService.getAvailableSlots(
      widget.selectedDate,
    );

    if (mounted) {
      setState(() {
        _allSlots = slots;
        _isLoading = false;
      });
    }
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
    widget.onTimeSelected(time);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final morningSlots = TimeSlotGenerator.getMorningSlots(_allSlots);
    final afternoonSlots = TimeSlotGenerator.getAfternoonSlots(_allSlots);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Horarios Disponibles',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          if (morningSlots.isNotEmpty) ...[
            _buildPeriodHeader('Mañana', '9:00 AM - 12:00 PM'),
            const SizedBox(height: 12),
            _buildTimeGrid(morningSlots),
            const SizedBox(height: 20),
          ],

          if (afternoonSlots.isNotEmpty) ...[
            _buildPeriodHeader('Tarde', '12:00 PM - 7:00 PM'),
            const SizedBox(height: 12),
            _buildTimeGrid(afternoonSlots),
          ],

          if (_allSlots.isEmpty ||
              _allSlots.every((slot) => !slot.isAvailable)) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.event_busy, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      'No hay horarios disponibles',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Por favor, selecciona otro día',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPeriodHeader(String period, String hours) {
    return Row(
      children: [
        Icon(
          period == 'Mañana' ? Icons.wb_sunny : Icons.wb_twilight,
          size: 20,
          color: Colors.blue[700],
        ),
        const SizedBox(width: 8),
        Text(
          period,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
        ),
        const SizedBox(width: 8),
        Text(hours, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTimeGrid(List<TimeSlot> slots) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: slots.map((slot) => _buildTimeChip(slot)).toList(),
    );
  }

  Widget _buildTimeChip(TimeSlot slot) {
    final isSelected = _selectedTime == slot.time;
    final isAvailable = slot.isAvailable;

    return InkWell(
      onTap: isAvailable ? () => _selectTime(slot.time) : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.blue[700]
                  : (isAvailable ? Colors.white : Colors.grey[200]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected
                    ? Colors.blue[700]!
                    : (isAvailable ? Colors.grey[300]! : Colors.grey[200]!),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          slot.time,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color:
                isSelected
                    ? Colors.white
                    : (isAvailable ? Colors.black87 : Colors.grey[400]),
          ),
        ),
      ),
    );
  }
}
