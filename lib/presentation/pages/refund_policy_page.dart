import 'package:flutter/material.dart';

/// Página de Política de Reembolsos
class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Reembolsos'),
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
                'Política de Reembolsos y Cancelaciones',
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
                title: '1. Política General de Cancelación',
                content:
                    'En ByLetyTravels entendemos que los planes pueden cambiar. Nuestra política de cancelación varía según el tiempo de anticipación:',
              ),

              _buildCancellationTier(
                days: '30+ días',
                percentage: '100%',
                description: 'Reembolso completo del monto pagado',
                color: Colors.green,
              ),

              _buildCancellationTier(
                days: '15-30 días',
                percentage: '50%',
                description:
                    'Reembolso del 50%, se retiene 50% por costos operativos',
                color: Colors.orange,
              ),

              _buildCancellationTier(
                days: 'Menos de 15 días',
                percentage: '0%',
                description: 'Sin reembolso - no cancelable',
                color: Colors.red,
              ),

              const SizedBox(height: 24),

              _buildSection(
                title: '2. Proceso de Cancelación',
                content: 'Para cancelar tu reserva:',
                bulletPoints: [
                  'Envía un correo a cancellations@byletytravels.com',
                  'Incluye tu número de reserva y nombre completo',
                  'Indica el motivo de la cancelación',
                  'Recibirás confirmación en 24-48 horas hábiles',
                  'El reembolso se procesa en 5-10 días hábiles',
                ],
              ),

              _buildSection(
                title: '3. Excepciones y Casos Especiales',
                content: 'Algunas situaciones especiales incluyen:',
                bulletPoints: [
                  'Emergencias médicas: reembolso del 75% con certificado médico',
                  'Fallecimiento familiar directo: reembolso del 90%',
                  'Desastres naturales: reembolso completo o reprogramación',
                  'Pandemias declaradas por OMS: política flexible según situación',
                  'Cambios gubernamentales (visas denegadas): reembolso del 80%',
                ],
              ),

              _buildSection(
                title: '4. Modificación de Reservas',
                content: 'Si deseas modificar tu reserva en lugar de cancelar:',
                bulletPoints: [
                  'Cambio de fecha: cargo del 10% del total',
                  'Cambio de destino: cargo del 20% + diferencia de precio',
                  'Cambio de pasajeros: cargo del 5% por persona',
                  'Upgrade de habitación: solo pagar diferencia',
                  'Las modificaciones deben solicitarse con 15+ días de anticipación',
                ],
              ),

              _buildSection(
                title: '5. Servicios No Reembolsables',
                content: 'Los siguientes conceptos NO son reembolsables:',
                bulletPoints: [
                  'Tarifas de procesamiento y gestión',
                  'Costos de visa ya tramitada',
                  'Seguros de viaje contratados (consultar con aseguradora)',
                  'Servicios adicionales ya prestados',
                  'Tours o actividades ya realizadas',
                  'Ofertas especiales marcadas como "no reembolsables"',
                ],
              ),

              _buildSection(
                title: '6. Cancelación por Parte de ByLetyTravels',
                content: 'Si cancelamos tu viaje por nuestra cuenta:',
                bulletPoints: [
                  'Reembolso del 100% garantizado',
                  'O reprogramación sin cargo adicional',
                  'Compensación adicional según caso',
                  'Notificación inmediata por correo y teléfono',
                  'Asistencia para encontrar alternativas',
                ],
              ),

              _buildSection(
                title: '7. No Shows (No Presentarse)',
                content: 'Si no te presentas al viaje sin previo aviso:',
                bulletPoints: [
                  'No hay reembolso del monto pagado',
                  'Los servicios se consideran consumidos',
                  'No se puede reprogramar',
                  'Posible cargo adicional por servicios reservados',
                ],
              ),

              _buildSection(
                title: '8. Retrasos y Cancelaciones de Vuelos',
                content: 'Si tu vuelo se retrasa o cancela:',
                bulletPoints: [
                  'Por aerolínea: sujeto a política de la aerolínea',
                  'Asistencia de ByLetyTravels para reprogramar',
                  'Sin cargo adicional por gestión',
                  'Reclamaciones se hacen directamente con aerolínea',
                  'Seguro de viaje puede cubrir gastos adicionales',
                ],
              ),

              _buildSection(
                title: '9. Método de Reembolso',
                content: 'Los reembolsos se procesan mediante:',
                bulletPoints: [
                  'Mismo método de pago original',
                  'Depósito bancario (si el método original no está disponible)',
                  'Crédito para futuras reservas (opcional, con 10% extra)',
                  'Los tiempos varían según método de pago (5-15 días)',
                ],
              ),

              _buildSection(
                title: '10. Seguros de Viaje',
                content:
                    'Recomendamos encarecidamente contratar seguro de viaje que cubra:',
                bulletPoints: [
                  'Cancelación por cualquier motivo',
                  'Interrupción del viaje',
                  'Emergencias médicas',
                  'Pérdida de equipaje',
                  'Retrasos significativos',
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
                  border: Border.all(color: Colors.blue[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.blue[800],
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Consejos para Evitar Cargos de Cancelación',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF072A47),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTip('Reserva con suficiente anticipación'),
                    _buildTip('Contrata seguro de cancelación flexible'),
                    _buildTip('Lee bien las condiciones antes de reservar'),
                    _buildTip('Guarda todos los comprobantes y confirmaciones'),
                    _buildTip(
                      'Contacta lo antes posible si necesitas cancelar',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _buildSection(
                title: '11. Contacto para Cancelaciones',
                content: 'Para procesar una cancelación o modificación:',
                bulletPoints: [
                  'Email: cancellations@byletytravels.com',
                  'Teléfono: +54 9 3884102859',
                  'WhatsApp: +54 9 3884102859',
                  'Horario: Lunes a Viernes, 9 AM - 7 PM',
                ],
              ),

              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red[700],
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Importante: Las políticas de cancelación pueden variar según el destino, temporada y proveedor. Siempre verifica las condiciones específicas de tu reserva en el email de confirmación.',
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 14,
                          height: 1.5,
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

  Widget _buildCancellationTier({
    required String days,
    required String percentage,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              percentage,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  days,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.blue[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(fontSize: 15, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
