import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:by_lety_travels/data/services/contact_service.dart';
import 'package:by_lety_travels/utils/responsive_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Botón flotante de WhatsApp con animación de pulso y badge de estado
class FloatingWhatsAppButton extends StatefulWidget {
  final String? packageName;
  final double? bottom;
  final double? right;

  const FloatingWhatsAppButton({
    super.key,
    this.packageName,
    this.bottom = 24.0,
    this.right = 24.0,
  });

  @override
  State<FloatingWhatsAppButton> createState() => _FloatingWhatsAppButtonState();
}

class _FloatingWhatsAppButtonState extends State<FloatingWhatsAppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
    final url = ContactService.getWhatsAppUrl(packageName: widget.packageName);
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No se pudo abrir WhatsApp. Por favor, instala la aplicación.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al abrir WhatsApp: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = ContactService.isOpenNow();
    final isMobile = ResponsiveUtils.isMobile(context);

    // Tamaños responsive
    final badgeFontSize = isMobile ? 10.0 : 12.0;
    final bottomPosition = isMobile ? (widget.bottom! * 0.8) : widget.bottom!;
    final rightPosition = isMobile ? (widget.right! * 0.7) : widget.right!;

    return Positioned(
      bottom: bottomPosition,
      right: rightPosition,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Badge de estado
          if (isOpen &&
              !isMobile) // Ocultar badge en móvil para ahorrar espacio
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'En línea',
                    style: TextStyle(
                      fontSize: badgeFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),

          // Botón flotante con animación de pulso
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF25D366).withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: _openWhatsApp,
                backgroundColor: const Color(0xFF25D366),
                elevation: 8,
                child: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: isMobile ? 28 : 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Versión compacta del botón (solo icono)
class FloatingWhatsAppButtonCompact extends StatefulWidget {
  final String? packageName;
  final double? bottom;
  final double? right;
  final bool showBadge;

  const FloatingWhatsAppButtonCompact({
    super.key,
    this.packageName,
    this.bottom = 24.0,
    this.right = 24.0,
    this.showBadge = true,
  });

  @override
  State<FloatingWhatsAppButtonCompact> createState() =>
      _FloatingWhatsAppButtonCompactState();
}

class _FloatingWhatsAppButtonCompactState
    extends State<FloatingWhatsAppButtonCompact>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
    final url = ContactService.getWhatsAppUrl(packageName: widget.packageName);
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo abrir WhatsApp'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = ContactService.isOpenNow();

    return Positioned(
      bottom: widget.bottom,
      right: widget.right,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _pulseAnimation.value, child: child);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF25D366).withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: _openWhatsApp,
                backgroundColor: const Color(0xFF25D366),
                elevation: 8,
                child: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),

            // Badge "En línea"
            if (widget.showBadge && isOpen)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
