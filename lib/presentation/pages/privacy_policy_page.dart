import 'package:flutter/material.dart';

/// Página de Política de Privacidad
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidad'),
        backgroundColor: const Color(0xFF072A47),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Política de Privacidad',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Última actualización: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),

              _buildSection(
                title: '1. Información que Recopilamos',
                content:
                    'En ByLetyTravels, nos comprometemos a proteger tu privacidad. Recopilamos la siguiente información:',
                bulletPoints: [
                  'Información personal: nombre, apellidos, correo electrónico, número de teléfono',
                  'Información de viaje: destinos de interés, fechas de viaje, preferencias',
                  'Información de pago: datos de tarjeta de crédito (procesados de forma segura)',
                  'Información de navegación: cookies, dirección IP, tipo de navegador',
                  'Documentación: número de pasaporte o DNI, fecha de nacimiento (cuando sea necesario)',
                ],
              ),

              _buildSection(
                title: '2. Cómo Usamos tu Información',
                content: 'Utilizamos la información recopilada para:',
                bulletPoints: [
                  'Procesar tus reservas y pagos de viajes',
                  'Enviarte confirmaciones y actualizaciones sobre tu viaje',
                  'Proporcionar atención al cliente y soporte',
                  'Mejorar nuestros servicios y experiencia de usuario',
                  'Enviarte ofertas promocionales (solo si has dado tu consentimiento)',
                  'Cumplir con requisitos legales y regulatorios',
                ],
              ),

              _buildSection(
                title: '3. Compartir Información',
                content:
                    'No vendemos tu información personal. Compartimos datos solo con:',
                bulletPoints: [
                  'Proveedores de servicios de viaje (aerolíneas, hoteles, tours)',
                  'Procesadores de pago seguros (Stripe, PayPal)',
                  'Servicios de análisis (Google Analytics) - datos anonimizados',
                  'Autoridades legales cuando sea requerido por ley',
                ],
              ),

              _buildSection(
                title: '4. Protección de Datos',
                content:
                    'Implementamos medidas de seguridad para proteger tu información:',
                bulletPoints: [
                  'Encriptación SSL/TLS para todas las transmisiones de datos',
                  'Almacenamiento seguro en servidores protegidos',
                  'Acceso restringido solo a personal autorizado',
                  'Auditorías de seguridad regulares',
                  'Cumplimiento con estándares PCI DSS para pagos',
                ],
              ),

              _buildSection(
                title: '5. Tus Derechos',
                content: 'Como usuario, tienes derecho a:',
                bulletPoints: [
                  'Acceder a tu información personal almacenada',
                  'Corregir datos incorrectos o desactualizados',
                  'Solicitar la eliminación de tus datos (derecho al olvido)',
                  'Oponerte al procesamiento de tus datos',
                  'Portabilidad de datos - recibir tus datos en formato estructurado',
                  'Retirar tu consentimiento en cualquier momento',
                ],
              ),

              _buildSection(
                title: '6. Cookies',
                content:
                    'Utilizamos cookies para mejorar tu experiencia. Puedes controlar las cookies desde la configuración de tu navegador. Para más información, consulta nuestra Política de Cookies.',
              ),

              _buildSection(
                title: '7. Menores de Edad',
                content:
                    'Nuestros servicios no están dirigidos a menores de 18 años. No recopilamos intencionalmente información de menores sin consentimiento parental.',
              ),

              _buildSection(
                title: '8. Cambios en la Política',
                content:
                    'Podemos actualizar esta política periódicamente. Te notificaremos sobre cambios significativos por correo electrónico o mediante un aviso destacado en nuestro sitio web.',
              ),

              _buildSection(
                title: '9. Contacto',
                content:
                    'Si tienes preguntas sobre esta política de privacidad, contáctanos:',
                bulletPoints: [
                  'Email: byletytravels.oficial@gmail.com',
                  'Teléfono: +54 9 3884102859',
                  'Dirección: [Tu dirección física]',
                ],
              ),

              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Al utilizar nuestros servicios, aceptas esta Política de Privacidad.',
                        style: TextStyle(color: Colors.blue[900], fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    List<String>? bulletPoints,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF072A47),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
          if (bulletPoints != null) ...[
            const SizedBox(height: 12),
            ...bulletPoints.map(
              (point) => Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF072A47),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
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
}
