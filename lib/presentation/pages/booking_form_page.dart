import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/data/models/booking_data.dart';
import 'package:by_lety_travels/data/models/coupon.dart';
import 'package:by_lety_travels/data/services/coupon_service.dart';
import 'package:by_lety_travels/data/services/email_service.dart';
import 'package:by_lety_travels/data/services/voucher_service.dart';
import 'package:universal_html/html.dart' as html;

/// Comprehensive booking form page
class BookingFormPage extends StatefulWidget {
  final PackageTravel package;

  const BookingFormPage({super.key, required this.package});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Controllers for form fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passportController = TextEditingController();
  final _specialRequestsController = TextEditingController();
  final _couponController = TextEditingController();

  // Form state
  String _selectedCountryCode = '+54'; // Default Argentina
  String _selectedCountry = 'Argentina';
  DateTime? _birthDate;
  DateTime? _departureDate;
  int _numberOfAdults = 1;
  int _numberOfChildren = 0;
  int _numberOfInfants = 0;
  RoomType _roomType = RoomType.double;

  // Additional services
  bool _travelInsurance = false;
  bool _airportTransfer = false;
  bool _additionalTour = false;
  bool _hotelUpgrade = false;
  bool _preferredSeats = false;

  // Coupon state
  Coupon? _appliedCoupon;
  String? _couponErrorMessage;
  bool _couponApplied = false;

  // UI state
  bool _isSubmitting = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passportController.dispose();
    _specialRequestsController.dispose();
    _couponController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  BookingData get _currentBookingData => BookingData(
    firstName: _firstNameController.text,
    lastName: _lastNameController.text,
    email: _emailController.text,
    phoneCountryCode: _selectedCountryCode,
    phoneNumber: _phoneController.text,
    countryOfResidence: _selectedCountry,
    birthDate: _birthDate,
    passportNumber:
        _passportController.text.isEmpty ? null : _passportController.text,
    packageTitle: widget.package.title,
    departureDate: _departureDate,
    numberOfAdults: _numberOfAdults,
    numberOfChildren: _numberOfChildren,
    numberOfInfants: _numberOfInfants,
    roomType: _roomType,
    travelInsurance: _travelInsurance,
    airportTransfer: _airportTransfer,
    additionalTour: _additionalTour,
    hotelUpgrade: _hotelUpgrade,
    preferredSeats: _preferredSeats,
    specialRequests:
        _specialRequestsController.text.isEmpty
            ? null
            : _specialRequestsController.text,
    appliedCoupon: _appliedCoupon,
    basePrice:
        double.tryParse(
          widget.package.price.replaceAll(RegExp(r'[^\d.]'), ''),
        ) ??
        0,
  );

  void _applyCoupon() {
    final code = _couponController.text.trim();
    if (code.isEmpty) {
      setState(() {
        _couponErrorMessage = 'Ingrese un código de cupón';
      });
      return;
    }

    // Get current subtotal for validation
    final currentSubtotal = _currentBookingData.subtotalBeforeDiscount;

    // Try to validate coupon
    final coupon = CouponService.getCouponByCode(code);

    if (coupon == null) {
      setState(() {
        _appliedCoupon = null;
        _couponApplied = false;
        _couponErrorMessage = 'Código de cupón inválido';
      });
      return;
    }

    // Check if coupon is valid and applicable
    final invalidReason = coupon.getInvalidReason(currentSubtotal);
    if (invalidReason != null) {
      setState(() {
        _appliedCoupon = null;
        _couponApplied = false;
        _couponErrorMessage = invalidReason;
      });
      return;
    }

    // Apply coupon successfully
    setState(() {
      _appliedCoupon = coupon;
      _couponApplied = true;
      _couponErrorMessage = null;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Cupón aplicado! ${coupon.getDiscountDisplay()} de descuento',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeCoupon() {
    setState(() {
      _appliedCoupon = null;
      _couponApplied = false;
      _couponErrorMessage = null;
      _couponController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cupón removido'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor complete todos los campos requeridos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Generate booking number
      final bookingNumber =
          'BLT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      final bookingData = _currentBookingData;

      // Send emails (client and business)
      await EmailService.sendBookingEmails(
        bookingNumber: bookingNumber,
        bookingData: bookingData,
        package: widget.package,
      );

      setState(() => _isSubmitting = false);

      if (!mounted) return;

      // Show success dialog
      await _showConfirmationDialog(bookingNumber, bookingData);
    } catch (e) {
      setState(() => _isSubmitting = false);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al procesar la reserva: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showConfirmationDialog(
    String bookingNumber,
    BookingData bookingData,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[600], size: 32),
                const SizedBox(width: 12),
                const Text('¡Reserva Confirmada!'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tu reserva ha sido procesada exitosamente.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Número de Reserva',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bookingNumber,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF072A47),
                        ),
                      ),
                      const Divider(height: 24),
                      _buildConfirmationRow('Paquete:', widget.package.title),
                      _buildConfirmationRow(
                        'Viajeros:',
                        '${bookingData.totalTravelers}',
                      ),
                      _buildConfirmationRow(
                        'Total:',
                        '\$${bookingData.totalAmount.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Hemos enviado un email de confirmación a ${_emailController.text}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back to previous page
                },
                child: const Text('Cerrar'),
              ),
              ElevatedButton.icon(
                onPressed: () => _downloadVoucher(bookingNumber, bookingData),
                icon: const Icon(Icons.download),
                label: const Text('Descargar Voucher'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF072A47),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _downloadVoucher(
    String bookingNumber,
    BookingData bookingData,
  ) async {
    try {
      // Generate PDF
      final pdfBytes = await VoucherService.generateVoucherPdf(
        bookingNumber: bookingNumber,
        bookingData: bookingData,
        package: widget.package,
      );

      // Create download link for web
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', 'Voucher_$bookingNumber.pdf')
        ..click();
      html.Url.revokeObjectUrl(url);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Voucher descargado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al descargar el voucher: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildConfirmationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Formulario de Reserva'),
        backgroundColor: const Color(0xFF072A47),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body:
          _isSubmitting
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF072A47),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Procesando tu reserva...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF072A47),
                      ),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 32),
                  child: Form(
                    key: _formKey,
                    child:
                        isMobile
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFormContent(isMobile),
                                const SizedBox(height: 24),
                                _buildBookingSummary(isMobile),
                              ],
                            )
                            : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildFormContent(isMobile),
                                ),
                                const SizedBox(width: 32),
                                Expanded(
                                  flex: 1,
                                  child: _buildBookingSummary(isMobile),
                                ),
                              ],
                            ),
                  ),
                ),
              ),
    );
  }

  Widget _buildFormContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('📋 Información del Viajero', required: true),
        _buildTravelerInfoSection(),
        const SizedBox(height: 32),
        _buildSectionHeader('✈️ Detalles de la Reserva', required: true),
        _buildBookingDetailsSection(),
        const SizedBox(height: 32),
        _buildSectionHeader('➕ Servicios Adicionales'),
        _buildAdditionalServicesSection(),
        const SizedBox(height: 32),
        _buildSectionHeader('🎟️ Código de Descuento'),
        _buildCouponSection(),
        const SizedBox(height: 32),
        _buildSectionHeader('💬 Comentarios o Solicitudes Especiales'),
        _buildSpecialRequestsSection(),
        const SizedBox(height: 32),
        if (isMobile)
          SizedBox(width: double.infinity, child: _buildSubmitButton()),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF072A47),
            ),
          ),
          if (required) ...[
            const SizedBox(width: 8),
            const Text(
              '* Campos obligatorios',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTravelerInfoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre *',
                    hintText: 'Juan',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nombre es requerido';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Apellidos *',
                    hintText: 'Pérez García',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Apellidos son requeridos';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email *',
              hintText: 'juan.perez@email.com',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email es requerido';
              }
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Email inválido';
              }
              return null;
            },
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: DropdownButtonFormField<String>(
                  value: _selectedCountryCode,
                  decoration: const InputDecoration(
                    labelText: 'Código',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: '+51', child: Text('+51 🇵🇪')),
                    DropdownMenuItem(value: '+1', child: Text('+1 🇺🇸')),
                    DropdownMenuItem(value: '+52', child: Text('+52 🇲🇽')),
                    DropdownMenuItem(value: '+34', child: Text('+34 🇪🇸')),
                    DropdownMenuItem(value: '+54', child: Text('+54 🇦🇷')),
                    DropdownMenuItem(value: '+56', child: Text('+56 🇨🇱')),
                    DropdownMenuItem(value: '+57', child: Text('+57 🇨🇴')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedCountryCode = value!);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Teléfono *',
                    hintText: '999888777',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Teléfono es requerido';
                    }
                    if (value.length < 6) {
                      return 'Teléfono inválido';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedCountry,
            decoration: const InputDecoration(
              labelText: 'País de Residencia *',
              prefixIcon: Icon(Icons.flag_outlined),
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Perú', child: Text('🇵🇪 Perú')),
              DropdownMenuItem(
                value: 'Estados Unidos',
                child: Text('🇺🇸 Estados Unidos'),
              ),
              DropdownMenuItem(value: 'México', child: Text('🇲🇽 México')),
              DropdownMenuItem(value: 'España', child: Text('🇪🇸 España')),
              DropdownMenuItem(
                value: 'Argentina',
                child: Text('🇦🇷 Argentina'),
              ),
              DropdownMenuItem(value: 'Chile', child: Text('🇨🇱 Chile')),
              DropdownMenuItem(value: 'Colombia', child: Text('🇨🇴 Colombia')),
              DropdownMenuItem(value: 'Brasil', child: Text('🇧🇷 Brasil')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'País es requerido';
              }
              return null;
            },
            onChanged: (value) {
              setState(() => _selectedCountry = value!);
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(
                        const Duration(days: 365 * 25),
                      ),
                      firstDate: DateTime(1940),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF072A47),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (date != null) {
                      setState(() => _birthDate = date);
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      prefixIcon: Icon(Icons.cake_outlined),
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      _birthDate == null
                          ? 'Seleccionar fecha'
                          : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                      style: TextStyle(
                        color: _birthDate == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _passportController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Pasaporte o DNI',
                    hintText: 'AB123456',
                    prefixIcon: Icon(Icons.card_travel_outlined),
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                    LengthLimitingTextInputFormatter(12),
                  ],
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Package pre-filled
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF072A47).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF072A47).withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.luggage, color: Color(0xFF072A47)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Paquete Seleccionado',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.package.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF072A47),
                        ),
                      ),
                      Text(
                        '${widget.package.duration} • ${widget.package.location}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.package.price,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF072A47),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Available dates selection
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF072A47),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Fecha de Salida Preferida *',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF072A47),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (widget.package.availableDates.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Text(
                    'No hay fechas disponibles en este momento',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      widget.package.availableDates.map((date) {
                        final isSelected =
                            _departureDate != null &&
                            _departureDate!.year == date.year &&
                            _departureDate!.month == date.month &&
                            _departureDate!.day == date.day;

                        return ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_today, size: 14),
                              const SizedBox(width: 6),
                              Text(
                                '${date.day}/${date.month}/${date.year}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _departureDate = selected ? date : null;
                            });
                          },
                          selectedColor: const Color(0xFF072A47),
                          backgroundColor: const Color(0xFFF5F5F5),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                          side: BorderSide(
                            color:
                                isSelected
                                    ? const Color(0xFF072A47)
                                    : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                        );
                      }).toList(),
                ),
              if (_departureDate == null && _formKey.currentState != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    'Seleccione una fecha de salida',
                    style: TextStyle(color: Colors.red[700], fontSize: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Número de Viajeros',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF072A47),
            ),
          ),
          const SizedBox(height: 12),
          _buildTravelerCounter(
            'Adultos',
            'Mayores de 12 años',
            _numberOfAdults,
            (value) => setState(() => _numberOfAdults = value),
            min: 1,
          ),
          const Divider(height: 24),
          _buildTravelerCounter(
            'Niños',
            '2-12 años (70% del precio)',
            _numberOfChildren,
            (value) => setState(() => _numberOfChildren = value),
          ),
          const Divider(height: 24),
          _buildTravelerCounter(
            'Infantes',
            '0-2 años (10% del precio)',
            _numberOfInfants,
            (value) => setState(() => _numberOfInfants = value),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tipo de Habitación',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF072A47),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children:
                RoomType.values.map((type) {
                  final isSelected = _roomType == type;
                  return ChoiceChip(
                    label: Text(type.label),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _roomType = type);
                    },
                    selectedColor: const Color(0xFF072A47),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelerCounter(
    String label,
    String description,
    int value,
    Function(int) onChanged, {
    int min = 0,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: value > min ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove_circle_outline),
              color: const Color(0xFF072A47),
            ),
            Container(
              width: 50,
              alignment: Alignment.center,
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () => onChanged(value + 1),
              icon: const Icon(Icons.add_circle_outline),
              color: const Color(0xFF072A47),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalServicesSection() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.engineering_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'PRÓXIMAMENTE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Los servicios adicionales estarán disponibles pronto',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coupon input
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    labelText: 'Código de Cupón',
                    hintText: 'Ingresa WELCOME10',
                    prefixIcon: const Icon(Icons.discount_outlined),
                    border: const OutlineInputBorder(),
                    errorText: _couponErrorMessage,
                    enabled: !_couponApplied,
                  ),
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                    LengthLimitingTextInputFormatter(20),
                  ],
                  onChanged: (_) {
                    if (_couponErrorMessage != null) {
                      setState(() => _couponErrorMessage = null);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              if (!_couponApplied)
                ElevatedButton(
                  onPressed: _applyCoupon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF072A47),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                  ),
                  child: const Text('Aplicar'),
                )
              else
                ElevatedButton.icon(
                  onPressed: _removeCoupon,
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Remover'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                  ),
                ),
            ],
          ),

          // Success message when coupon is applied
          if (_couponApplied && _appliedCoupon != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green[700], size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Cupón Aplicado!',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_appliedCoupon!.code}: ${_appliedCoupon!.description}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green[800],
                          ),
                        ),
                        Text(
                          'Descuento: ${_appliedCoupon!.getDiscountDisplay()}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Recommended coupons
          if (!_couponApplied) ...[
            const SizedBox(height: 20),
            const Text(
              'Cupones Disponibles:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  CouponService.getRecommendedCoupons(
                    limit: 4,
                  ).map((coupon) => _buildCouponChip(coupon)).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCouponChip(Coupon coupon) {
    return InkWell(
      onTap: () {
        _couponController.text = coupon.code;
        _applyCoupon();
      },
      child: Chip(
        avatar: const Icon(Icons.local_offer, size: 16),
        label: Text(
          '${coupon.code} - ${coupon.getDiscountDisplay()}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFFFFDC00).withOpacity(0.2),
        side: const BorderSide(color: Color(0xFF072A47), width: 1),
      ),
    );
  }

  Widget _buildSpecialRequestsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _specialRequestsController,
        maxLines: 5,
        maxLength: 500,
        decoration: const InputDecoration(
          hintText:
              'Ejemplo: Necesito habitación en piso bajo, soy vegetariano, celebración de cumpleaños...',
          border: OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildBookingSummary(bool isMobile) {
    final bookingData = _currentBookingData;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFF072A47).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen de Reserva',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF072A47),
            ),
          ),
          const SizedBox(height: 20),
          // Package info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.luggage, color: Color(0xFF072A47), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.package.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_departureDate != null)
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey[600], size: 16),
                const SizedBox(width: 8),
                Text(
                  '${_departureDate!.day}/${_departureDate!.month}/${_departureDate!.year}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.people, color: Colors.grey[600], size: 16),
              const SizedBox(width: 8),
              Text(
                '${bookingData.totalTravelers} Viajero${bookingData.totalTravelers > 1 ? "s" : ""}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
          const Divider(height: 32),
          // Price breakdown
          const Text(
            'Desglose de Precios',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF072A47),
            ),
          ),
          const SizedBox(height: 16),
          if (_numberOfAdults > 0)
            _buildPriceRow(
              'Precio base × $_numberOfAdults adulto${_numberOfAdults > 1 ? "s" : ""}',
              bookingData.basePrice * _numberOfAdults,
            ),
          if (_numberOfChildren > 0)
            _buildPriceRow(
              'Precio × $_numberOfChildren niño${_numberOfChildren > 1 ? "s" : ""} (70%)',
              bookingData.basePrice * 0.7 * _numberOfChildren,
            ),
          if (_numberOfInfants > 0)
            _buildPriceRow(
              'Precio × $_numberOfInfants infante${_numberOfInfants > 1 ? "s" : ""} (10%)',
              bookingData.basePrice * 0.1 * _numberOfInfants,
            ),
          if (bookingData.additionalServicesCost > 0) ...[
            const SizedBox(height: 12),
            const Text(
              'Servicios Adicionales',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (_travelInsurance)
            _buildPriceRow(
              'Seguro de viaje × ${bookingData.totalTravelers}',
              bookingData.insurancePrice * bookingData.totalTravelers,
            ),
          if (_airportTransfer)
            _buildPriceRow(
              'Traslado × ${bookingData.totalTravelers}',
              bookingData.transferPrice * bookingData.totalTravelers,
            ),
          if (_additionalTour)
            _buildPriceRow(
              'Tour adicional × ${bookingData.totalTravelers}',
              bookingData.tourPrice * bookingData.totalTravelers,
            ),
          if (_hotelUpgrade)
            _buildPriceRow('Upgrade hotel 5★', bookingData.upgradePrice),
          if (_preferredSeats)
            _buildPriceRow(
              'Asientos preferentes × ${_numberOfAdults + _numberOfChildren}',
              bookingData.seatsPrice * (_numberOfAdults + _numberOfChildren),
            ),
          const Divider(height: 24),
          _buildPriceRow(
            'Subtotal',
            bookingData.subtotalBeforeDiscount,
            isBold: true,
          ),
          // Show discount if coupon is applied
          if (bookingData.appliedCoupon != null &&
              bookingData.discountAmount > 0) ...[
            _buildPriceRow(
              'Descuento (${bookingData.appliedCoupon!.code})',
              -bookingData.discountAmount,
              isDiscount: true,
            ),
            _buildPriceRow(
              'Subtotal con descuento',
              bookingData.subtotalAfterDiscount,
              isBold: true,
            ),
          ],
          _buildPriceRow(
            'Impuestos (${(bookingData.taxRate * 100).toStringAsFixed(0)}%)',
            bookingData.taxes,
          ),
          const Divider(height: 24),
          _buildPriceRow(
            'TOTAL A PAGAR',
            bookingData.totalAmount,
            isTotal: true,
          ),
          const SizedBox(height: 24),
          if (!isMobile) _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    double amount, {
    bool isBold = false,
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight:
                    isTotal || isBold ? FontWeight.bold : FontWeight.normal,
                color:
                    isDiscount
                        ? Colors.green[700]
                        : (isTotal
                            ? const Color(0xFF072A47)
                            : Colors.grey[700]),
              ),
            ),
          ),
          Text(
            '\$${amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 20 : 14,
              fontWeight: isTotal || isBold ? FontWeight.bold : FontWeight.w600,
              color:
                  isDiscount
                      ? Colors.green[700]
                      : (isTotal ? const Color(0xFF072A47) : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitBooking,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFDC00),
        foregroundColor: const Color(0xFF072A47),
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 24),
          SizedBox(width: 12),
          Text(
            'Confirmar Reserva',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
