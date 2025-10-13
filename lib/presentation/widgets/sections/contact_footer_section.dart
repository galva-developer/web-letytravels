import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:by_lety_travels/presentation/widgets/call_now_button.dart';
import 'package:by_lety_travels/presentation/widgets/quick_inquiry_dialog.dart';
import 'package:by_lety_travels/presentation/widgets/appointment_booking_dialog.dart';
import 'package:by_lety_travels/presentation/widgets/social_media_links.dart';
import 'package:by_lety_travels/presentation/pages/privacy_policy_page.dart';
import 'package:by_lety_travels/presentation/pages/terms_conditions_page.dart';
import 'package:by_lety_travels/presentation/pages/cookie_policy_page.dart';
import 'package:by_lety_travels/presentation/pages/refund_policy_page.dart';

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
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    const Spacer(),
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
                                    const Spacer(),
                                    const QuickInquiryButton(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (constraints.maxWidth > 600) {
                      // Tablet: 2 filas
                      return Column(
                        children: [
                          // Primera fila: Info de contacto + Asesoría
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        const Spacer(),
                                        const AppointmentBookingButton(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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

          // Footer copyright y políticas
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            color: Colors.grey[900],
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    // Redes sociales
                    const SocialMediaLinksExpanded(vertical: false),
                    const SizedBox(height: 40),

                    // Enlaces a políticas
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 32,
                      runSpacing: 16,
                      children: [
                        _PolicyLink(
                          text: 'Política de Privacidad',
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const PrivacyPolicyPage(),
                                ),
                              ),
                        ),
                        _PolicyLink(
                          text: 'Términos y Condiciones',
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const TermsConditionsPage(),
                                ),
                              ),
                        ),
                        _PolicyLink(
                          text: 'Política de Cookies',
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const CookiePolicyPage(),
                                ),
                              ),
                        ),
                        _PolicyLink(
                          text: 'Política de Reembolsos',
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const RefundPolicyPage(),
                                ),
                              ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Separador visual
                    Container(
                      height: 1,
                      color: Colors.white24,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                    ),

                    // Copyright y contacto
                    Column(
                      children: [
                        const Text(
                          '© 2025 ByLetyTravels. Todos los derechos reservados.',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Contacto: byletytravels.oficial@gmail.com | Tel: +54 9 3884102859',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Firma del desarrollador
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Desarrollado por ',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final url = Uri.parse(
                                  'https://www.linkedin.com/in/alvaro-developer/',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              onHover: (isHovering) {},
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Text(
                                  'Galva Dev',
                                  style: TextStyle(
                                    color: Color(0xFF0077B5), // LinkedIn blue
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Ícono de email
                            InkWell(
                              onTap: () async {
                                final emailUrl = Uri.parse(
                                  'mailto:alvaro.gonzales.dev@gmail.com?subject=Contacto%20desde%20ByLetyTravels',
                                );
                                if (await canLaunchUrl(emailUrl)) {
                                  await launchUrl(emailUrl);
                                }
                              },
                              child: const Tooltip(
                                message:
                                    'Enviar email a alvaro.gonzales.dev@gmail.com',
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Icon(
                                    Icons.email_outlined,
                                    size: 14,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget para enlaces de políticas en el footer
class _PolicyLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _PolicyLink({required this.text, required this.onTap});

  @override
  State<_PolicyLink> createState() => _PolicyLinkState();
}

class _PolicyLinkState extends State<_PolicyLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: _isHovered ? const Color(0xFFFFDC00) : Colors.white60,
            fontSize: 14,
            decoration:
                _isHovered ? TextDecoration.underline : TextDecoration.none,
            decorationColor: const Color(0xFFFFDC00),
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
