import 'package:flutter/material.dart';

/// Página de Política de Cookies
class CookiePolicyPage extends StatelessWidget {
  const CookiePolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Cookies'),
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
                'Política de Cookies',
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
                title: '1. ¿Qué son las Cookies?',
                content:
                    'Las cookies son pequeños archivos de texto que se almacenan en tu dispositivo cuando visitas un sitio web. Las cookies ayudan a que el sitio web funcione correctamente, sea más eficiente y proporcionen información a los propietarios del sitio.',
              ),

              _buildSection(
                title: '2. ¿Cómo Utilizamos las Cookies?',
                content: 'ByLetyTravels utiliza cookies para:',
                bulletPoints: [
                  'Mantener tu sesión activa mientras navegas',
                  'Recordar tus preferencias (idioma, moneda)',
                  'Guardar tu carrito de compras y favoritos',
                  'Analizar el tráfico web y comportamiento de usuarios',
                  'Personalizar contenido y ofertas',
                  'Mejorar la seguridad del sitio',
                  'Permitir funcionalidades de redes sociales',
                ],
              ),

              _buildSection(
                title: '3. Tipos de Cookies que Utilizamos',
                content: '',
              ),

              _buildCookieType(
                title: 'Cookies Esenciales',
                icon: Icons.check_circle_outline,
                color: Colors.green,
                description:
                    'Necesarias para el funcionamiento básico del sitio. No pueden desactivarse.',
                examples: [
                  'Cookies de sesión de usuario',
                  'Cookies de seguridad',
                  'Cookies de carga de balance',
                ],
              ),

              _buildCookieType(
                title: 'Cookies de Rendimiento',
                icon: Icons.speed,
                color: Colors.blue,
                description:
                    'Recopilan información sobre cómo usas el sitio para mejorar el rendimiento.',
                examples: [
                  'Google Analytics - análisis de tráfico',
                  'Mapas de calor y grabaciones de sesión',
                  'Métricas de velocidad de carga',
                ],
              ),

              _buildCookieType(
                title: 'Cookies de Funcionalidad',
                icon: Icons.settings,
                color: Colors.orange,
                description:
                    'Permiten que el sitio recuerde tus elecciones y proporcione características mejoradas.',
                examples: [
                  'Preferencias de idioma',
                  'Configuración de visualización',
                  'Favoritos y comparaciones guardadas',
                ],
              ),

              _buildCookieType(
                title: 'Cookies de Marketing',
                icon: Icons.campaign,
                color: Colors.purple,
                description:
                    'Se utilizan para rastrear visitantes en sitios web y mostrar anuncios relevantes.',
                examples: [
                  'Facebook Pixel',
                  'Google Ads',
                  'Remarketing y retargeting',
                ],
              ),

              const SizedBox(height: 24),

              _buildSection(
                title: '4. Cookies de Terceros',
                content:
                    'Utilizamos servicios de terceros que también pueden establecer cookies:',
                bulletPoints: [
                  'Google Analytics - análisis web',
                  'Facebook - integración de redes sociales',
                  'Stripe/PayPal - procesamiento de pagos',
                  'Google Maps - visualización de mapas',
                  'WhatsApp - widget de chat',
                ],
              ),

              _buildSection(
                title: '5. Duración de las Cookies',
                content: 'Las cookies pueden ser:',
                bulletPoints: [
                  'Cookies de sesión: se eliminan al cerrar el navegador',
                  'Cookies persistentes: permanecen por un tiempo determinado',
                  'Algunas cookies expiran después de 30 días',
                  'Otras pueden durar hasta 2 años',
                ],
              ),

              _buildSection(
                title: '6. Cómo Controlar las Cookies',
                content:
                    'Puedes controlar y/o eliminar las cookies según desees:',
                bulletPoints: [
                  'Configuración del navegador: ajusta las preferencias de cookies',
                  'Herramientas de terceros: usa extensiones de privacidad',
                  'Eliminar cookies: borra las cookies existentes en tu navegador',
                  'Rechazar cookies: algunos sitios permiten rechazar cookies no esenciales',
                ],
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[50]!, Colors.blue[100]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.blue[700],
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Instrucciones por Navegador',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF072A47),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildBrowserInstruction(
                      'Chrome',
                      'Configuración > Privacidad > Cookies',
                    ),
                    _buildBrowserInstruction(
                      'Firefox',
                      'Opciones > Privacidad > Cookies',
                    ),
                    _buildBrowserInstruction(
                      'Safari',
                      'Preferencias > Privacidad > Cookies',
                    ),
                    _buildBrowserInstruction(
                      'Edge',
                      'Configuración > Cookies y permisos',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _buildSection(
                title: '7. Consecuencias de Deshabilitar Cookies',
                content:
                    'Si deshabilitas las cookies, algunas funcionalidades pueden no estar disponibles:',
                bulletPoints: [
                  'No podrás iniciar sesión',
                  'Tus preferencias no se guardarán',
                  'El carrito de compras no funcionará',
                  'No se podrán personalizar ofertas',
                  'Algunas páginas pueden no cargarse correctamente',
                ],
              ),

              _buildSection(
                title: '8. Actualizaciones de la Política',
                content:
                    'Podemos actualizar esta Política de Cookies periódicamente para reflejar cambios en nuestras prácticas o por requisitos legales. Te notificaremos sobre cambios significativos.',
              ),

              _buildSection(
                title: '9. Más Información',
                content: 'Para más detalles sobre privacidad:',
                bulletPoints: [
                  'Consulta nuestra Política de Privacidad',
                  'Contacta: cookies@byletytravels.com',
                  'Teléfono: +54 9 3884102859',
                ],
              ),

              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.cookie, color: Colors.green[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Al continuar navegando en nuestro sitio, aceptas el uso de cookies de acuerdo con esta política.',
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 14,
                        ),
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
          if (content.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ],
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

  Widget _buildCookieType({
    required String title,
    required IconData icon,
    required Color color,
    required String description,
    required List<String> examples,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ejemplos:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          ...examples.map(
            (example) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                '• $example',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrowserInstruction(String browser, String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              browser,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF072A47),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
