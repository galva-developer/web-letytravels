import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:by_lety_travels/data/models/booking_data.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';

/// Service to generate PDF vouchers for bookings
class VoucherService {
  /// Generate a PDF voucher for a booking
  static Future<Uint8List> generateVoucherPdf({
    required String bookingNumber,
    required BookingData bookingData,
    required PackageTravel package,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(40),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with logo and title
                _buildHeader(),
                pw.SizedBox(height: 30),

                // Booking confirmation banner
                _buildConfirmationBanner(bookingNumber),
                pw.SizedBox(height: 30),

                // Customer information
                _buildSection('Información del Cliente', [
                  _buildInfoRow(
                    'Nombre Completo:',
                    '${bookingData.firstName} ${bookingData.lastName}',
                  ),
                  _buildInfoRow('Email:', bookingData.email),
                  _buildInfoRow(
                    'Teléfono:',
                    '${bookingData.phoneCountryCode} ${bookingData.phoneNumber}',
                  ),
                  _buildInfoRow(
                    'País de Residencia:',
                    bookingData.countryOfResidence,
                  ),
                  if (bookingData.passportNumber != null)
                    _buildInfoRow('Pasaporte:', bookingData.passportNumber!),
                ]),
                pw.SizedBox(height: 20),

                // Trip information
                _buildSection('Detalles del Viaje', [
                  _buildInfoRow('Paquete:', package.title),
                  _buildInfoRow('Destino:', package.location),
                  _buildInfoRow('Duración:', package.duration),
                  if (bookingData.departureDate != null)
                    _buildInfoRow(
                      'Fecha de Salida:',
                      '${bookingData.departureDate!.day}/${bookingData.departureDate!.month}/${bookingData.departureDate!.year}',
                    ),
                  _buildInfoRow(
                    'Tipo de Habitación:',
                    bookingData.roomType.label,
                  ),
                ]),
                pw.SizedBox(height: 20),

                // Travelers information
                _buildSection('Viajeros', [
                  _buildInfoRow('Adultos:', '${bookingData.numberOfAdults}'),
                  _buildInfoRow('Niños:', '${bookingData.numberOfChildren}'),
                  _buildInfoRow('Infantes:', '${bookingData.numberOfInfants}'),
                  _buildInfoRow(
                    'Total Viajeros:',
                    '${bookingData.totalTravelers}',
                    bold: true,
                  ),
                ]),
                pw.SizedBox(height: 20),

                // Price breakdown
                _buildPriceSection(bookingData),
                pw.SizedBox(height: 30),

                // Footer
                pw.Spacer(),
                _buildFooter(),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '✈ By Lety Travels',
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue900,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Tu aventura comienza aquí',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'VOUCHER DE RESERVA',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue900,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Fecha de emisión: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(color: PdfColors.blue900, thickness: 2),
      ],
    );
  }

  static pw.Widget _buildConfirmationBanner(String bookingNumber) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.green50,
        border: pw.Border.all(color: PdfColors.green700, width: 2),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Row(
        children: [
          pw.Container(
            width: 40,
            height: 40,
            decoration: const pw.BoxDecoration(
              color: PdfColors.green700,
              shape: pw.BoxShape.circle,
            ),
            child: pw.Center(
              child: pw.Text(
                '✓',
                style: pw.TextStyle(
                  fontSize: 24,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.SizedBox(width: 20),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '¡Reserva Confirmada!',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green900,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Número de Reserva: $bookingNumber',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSection(String title, List<pw.Widget> content) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
          pw.SizedBox(height: 12),
          ...content,
        ],
      ),
    );
  }

  static pw.Widget _buildInfoRow(
    String label,
    String value, {
    bool bold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 150,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 11,
                color: PdfColors.grey700,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 11,
                color: PdfColors.black,
                fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPriceSection(BookingData bookingData) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        border: pw.Border.all(color: PdfColors.blue900, width: 2),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Resumen de Precios',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
          pw.SizedBox(height: 12),
          _buildPriceRow(
            'Precio Base:',
            '\$${bookingData.basePrice.toStringAsFixed(2)}',
          ),
          if (bookingData.appliedCoupon != null) ...[
            _buildPriceRow(
              'Descuento (${bookingData.appliedCoupon!.code}):',
              '-\$${bookingData.discountAmount.toStringAsFixed(2)}',
              color: PdfColors.green700,
            ),
          ],
          pw.Divider(color: PdfColors.blue900),
          _buildPriceRow(
            'TOTAL:',
            '\$${bookingData.totalAmount.toStringAsFixed(2)}',
            bold: true,
            fontSize: 14,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPriceRow(
    String label,
    String value, {
    bool bold = false,
    double fontSize = 11,
    PdfColor? color,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: fontSize,
              color: color ?? PdfColors.black,
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: fontSize,
              color: color ?? PdfColors.black,
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 20),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.grey300, width: 1),
        ),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'By Lety Travels',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Email: byletytravels.oficial@gmail.com',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            'www.byletytravels.com',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Gracias por confiar en nosotros. ¡Buen viaje!',
            style: pw.TextStyle(
              fontSize: 10,
              fontStyle: pw.FontStyle.italic,
              color: PdfColors.grey600,
            ),
          ),
        ],
      ),
    );
  }
}
