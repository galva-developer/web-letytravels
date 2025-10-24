import 'package:flutter/material.dart';

/// Página de Términos y Condiciones
class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
        backgroundColor: const Color(0xFF072A47),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Términos y Condiciones',
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
                title: '1. Aceptación de Términos',
                content:
                    'Al acceder y utilizar los servicios de ByLetyTravels, aceptas estar sujeto a estos Términos y Condiciones. Si no estás de acuerdo con alguna parte de estos términos, no debes utilizar nuestros servicios.',
              ),

              _buildSection(
                title: '2. Descripción del Servicio',
                content: 'ByLetyTravels es una agencia de viajes que ofrece:',
                bulletPoints: [
                  'Reserva de paquetes turísticos',
                  'Reserva de vuelos, hoteles y tours',
                  'Asesoría personalizada de viajes',
                  'Gestión completa de itinerarios',
                  'Servicios adicionales relacionados con viajes',
                ],
              ),

              _buildSection(
                title: '3. Proceso de Reserva',
                content: 'Al realizar una reserva:',
                bulletPoints: [
                  'Debes proporcionar información precisa y completa',
                  'Confirmas tener la edad legal para contratar (18+ años)',
                  'Aceptas pagar el monto total indicado',
                  'Recibirás una confirmación por correo electrónico',
                  'La reserva está sujeta a disponibilidad',
                ],
              ),

              _buildSection(
                title: '4. Precios y Pagos',
                content: 'Política de precios:',
                bulletPoints: [
                  'Los precios están en dólares estadounidenses (USD)',
                  'Los precios incluyen impuestos salvo indicación contraria',
                  'Aceptamos tarjetas de crédito/débito, PayPal y transferencias',
                  'Los precios pueden cambiar sin previo aviso',
                  'Las ofertas especiales tienen validez limitada',
                  'Se requiere un depósito del 30% para confirmar reservas',
                ],
              ),

              _buildSection(
                title: '5. Cancelaciones y Reembolsos',
                content: 'Política de cancelación:',
                bulletPoints: [
                  'Cancelación con más de 30 días: reembolso del 100%',
                  'Cancelación entre 15-30 días: reembolso del 50%',
                  'Cancelación con menos de 15 días: sin reembolso',
                  'Los servicios no utilizados no son reembolsables',
                  'Para más detalles, consulta nuestra Política de Reembolsos',
                ],
              ),

              _buildSection(
                title: '6. Documentación de Viaje',
                content: 'Es responsabilidad del cliente:',
                bulletPoints: [
                  'Obtener pasaporte válido con al menos 6 meses de vigencia',
                  'Tramitar visas necesarias para los destinos',
                  'Contar con vacunas requeridas',
                  'Verificar requisitos de entrada de cada país',
                  'Mantener documentos personales seguros durante el viaje',
                ],
              ),

              _buildSection(
                title: '7. Seguros de Viaje',
                content:
                    'Recomendamos encarecidamente contratar un seguro de viaje que cubra:',
                bulletPoints: [
                  'Cancelaciones de viaje',
                  'Gastos médicos en el extranjero',
                  'Pérdida de equipaje',
                  'Retrasos y interrupciones de viaje',
                  'Repatriación de emergencia',
                ],
              ),

              _buildSection(
                title: '8. Limitación de Responsabilidad',
                content: 'ByLetyTravels no se hace responsable de:',
                bulletPoints: [
                  'Retrasos o cancelaciones de vuelos por causas externas',
                  'Pérdida de equipaje por parte de aerolíneas',
                  'Cambios en políticas de visado',
                  'Desastres naturales o eventos de fuerza mayor',
                  'Servicios prestados directamente por terceros',
                  'Problemas de salud no cubiertos por seguros',
                ],
              ),

              _buildSection(
                title: '9. Comportamiento del Cliente',
                content: 'Los clientes deben:',
                bulletPoints: [
                  'Comportarse de manera respetuosa',
                  'Cumplir con las leyes locales del destino',
                  'Seguir las instrucciones de guías y personal',
                  'No causar daños a propiedades o equipamiento',
                  'Respetar las políticas de los proveedores de servicios',
                ],
              ),

              _buildSection(
                title: '10. Propiedad Intelectual',
                content:
                    'Todo el contenido de ByLetyTravels (textos, imágenes, logos, diseño) está protegido por derechos de autor. No está permitido:',
                bulletPoints: [
                  'Copiar o reproducir contenido sin autorización',
                  'Usar nuestras marcas registradas',
                  'Extraer información con herramientas automatizadas',
                  'Modificar o crear trabajos derivados',
                ],
              ),

              _buildSection(
                title: '11. Modificaciones del Servicio',
                content: 'Nos reservamos el derecho de:',
                bulletPoints: [
                  'Modificar estos términos en cualquier momento',
                  'Cambiar o discontinuar servicios',
                  'Actualizar precios de paquetes',
                  'Modificar itinerarios por razones operativas',
                ],
              ),

              _buildSection(
                title: '12. Resolución de Disputas',
                content: 'En caso de disputas:',
                bulletPoints: [
                  'Intentaremos resolver el problema amigablemente',
                  'Se aplicará la ley de [tu jurisdicción]',
                  'Las disputas se resolverán mediante arbitraje',
                  'Puedes contactarnos en byletytravels.oficial@gmail.com',
                ],
              ),

              _buildSection(
                title: '13. Contacto',
                content: 'Para preguntas sobre estos términos:',
                bulletPoints: [
                  'Email: byletytravels.oficial@gmail.com',
                  'Teléfono: +54 9 3884102859',
                  'WhatsApp: +54 9 3884102859',
                ],
              ),

              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Al realizar una reserva, confirmas que has leído, entendido y aceptado estos Términos y Condiciones.',
                        style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
