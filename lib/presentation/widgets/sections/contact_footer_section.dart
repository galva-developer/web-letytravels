import 'package:flutter/material.dart';
import 'package:by_lety_travels/presentation/widgets/call_now_button.dart';
import 'package:by_lety_travels/presentation/widgets/quick_inquiry_dialog.dart';
import 'package:by_lety_travels/presentation/widgets/appointment_booking_dialog.dart';
import 'package:by_lety_travels/presentation/widgets/social_media_links.dart';

// Widget for the footer section, typically containing contact information or copyright.
class ContactFooterSection extends StatelessWidget {
  final GlobalKey sectionKey;

  // Constructor requiring a GlobalKey.
  const ContactFooterSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      color: const Color(0xFF072A47),
      child: Column(
        children: [
          // Sección de contacto rápido
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
            child: Column(
              children: [
                // Título
                const Text(
                  '📞 Contáctanos',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Estamos aquí para ayudarte a planificar tu próxima aventura',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Contenedor responsive para los métodos de contacto
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      // Desktop: 3 columnas
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card de información de contacto
                          const Expanded(child: ContactInfoCard()),
                          const SizedBox(width: 24),

                          // Botón de asesoría
                          Expanded(
                            child: Container(
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
                                  Icon(
                                    Icons.calendar_today,
                                    size: 48,
                                    color: Colors.green[700],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Asesoría Personalizada',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Agenda una cita gratuita con nuestros expertos',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const AppointmentBookingButton(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),

                          // Botón de consulta rápida
                          Expanded(
                            child: Container(
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
                                  Icon(
                                    Icons.mail_outline,
                                    size: 48,
                                    color: Colors.blue[700],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    '¿Tienes una consulta?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Envíanos un mensaje y te responderemos pronto',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const QuickInquiryButton(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (constraints.maxWidth > 600) {
                      // Tablet: 2 filas
                      return Column(
                        children: [
                          // Primera fila: Info de contacto + Asesoría
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: ContactInfoCard()),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 48,
                                        color: Colors.green[700],
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Asesoría Personalizada',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const AppointmentBookingButton(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Segunda fila: Consulta rápida
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  size: 48,
                                  color: Colors.blue[700],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  '¿Tienes una consulta?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const QuickInquiryButton(),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Móvil: 3 cards apiladas
                      return Column(
                        children: [
                          const ContactInfoCard(),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 48,
                                  color: Colors.green[700],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Asesoría Personalizada',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                const AppointmentBookingButton(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  size: 48,
                                  color: Colors.blue[700],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  '¿Tienes una consulta?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                const QuickInquiryButton(),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),

          // Footer copyright
          Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.grey[900],
            child: Column(
              children: [
                // Redes sociales
                const SocialMediaLinksExpanded(vertical: false),
                const SizedBox(height: 24),
                // Copyright
                const Text(
                  '© 2025 ByLetyTravels. Todos los derechos reservados. | Contacto: info@byletytravels.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
