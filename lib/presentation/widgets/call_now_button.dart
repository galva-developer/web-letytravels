import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:by_lety_travels/data/services/contact_service.dart';

/// Botón "Llamar Ahora" con número de teléfono y horario visible
class CallNowButton extends StatelessWidget {
  final bool isCompact;
  final bool showHours;

  const CallNowButton({
    super.key,
    this.isCompact = false,
    this.showHours = true,
  });

  Future<void> _makePhoneCall(BuildContext context) async {
    final url = ContactService.getPhoneCallUrl();
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo realizar la llamada'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al llamar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return _buildCompactButton(context);
    }
    return _buildFullButton(context);
  }

  Widget _buildCompactButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _makePhoneCall(context),
      icon: const Icon(Icons.phone, size: 20),
      label: Text(ContactService.phoneNumber),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildFullButton(BuildContext context) {
    final isOpen = ContactService.isOpenNow();
    final currentHours = ContactService.getCurrentBusinessHoursText();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.phone, color: Colors.blue[700], size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Llámanos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ContactService.phoneNumber,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (showHours) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),

            // Horario de atención
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'Horario de atención:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isOpen ? Colors.green[50] : Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isOpen ? Colors.green[200]! : Colors.orange[200]!,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isOpen ? Colors.green : Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isOpen ? currentHours : 'Cerrado - $currentHours',
                      style: TextStyle(
                        fontSize: 13,
                        color: isOpen ? Colors.green[900] : Colors.orange[900],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Botón de llamada
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _makePhoneCall(context),
              icon: const Icon(Icons.phone, size: 20),
              label: const Text(
                'Llamar Ahora',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget compacto con solo el ícono de teléfono
class CallNowIconButton extends StatelessWidget {
  const CallNowIconButton({super.key});

  Future<void> _makePhoneCall(BuildContext context) async {
    final url = ContactService.getPhoneCallUrl();
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo realizar la llamada'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _makePhoneCall(context),
      icon: const Icon(Icons.phone),
      tooltip: 'Llamar: ${ContactService.phoneNumber}',
      color: Colors.blue[700],
      iconSize: 24,
    );
  }
}

/// Widget de información de contacto completa (teléfono + horarios)
class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final businessHours = ContactService.getBusinessHoursList();
    final isOpen = ContactService.isOpenNow();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity, // Full width
      padding: EdgeInsets.all(isMobile ? 32 : 20), // More padding on mobile
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            isMobile
                ? BorderRadius.zero
                : BorderRadius.circular(12), // Sharp corners on mobile
        border:
            isMobile
                ? null
                : Border.all(color: Colors.grey[300]!), // No border on mobile
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
          // Estado actual
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isOpen ? Colors.green : Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isOpen ? 'Estamos disponibles' : 'Cerrado',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isOpen ? Colors.green[700] : Colors.orange[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Teléfono
          Row(
            children: [
              Icon(Icons.phone, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Teléfono:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                ContactService.phoneNumber,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // Horarios
          const Text(
            'Horarios de atención:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...businessHours.map((schedule) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      schedule['day']!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      schedule['hours']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),

          // Botón de llamada
          SizedBox(
            width: double.infinity,
            child: CallNowButton(isCompact: true, showHours: false),
          ),
        ],
      ),
    );
  }
}
