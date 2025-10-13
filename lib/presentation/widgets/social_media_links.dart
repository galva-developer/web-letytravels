import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget que muestra enlaces a redes sociales con iconos animados
class SocialMediaLinks extends StatelessWidget {
  final double iconSize;
  final bool showLabels;
  final MainAxisAlignment alignment;
  final Color? iconColor;
  final double spacing;

  const SocialMediaLinks({
    super.key,
    this.iconSize = 32,
    this.showLabels = false,
    this.alignment = MainAxisAlignment.center,
    this.iconColor,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        _SocialMediaButton(
          icon: _FacebookIcon(size: iconSize),
          label: 'Facebook',
          url: 'https://www.facebook.com/profile.php?id=61575652439979',
          color: const Color(0xFF1877F2),
          showLabel: showLabels,
          iconColor: iconColor,
        ),
        SizedBox(width: spacing),
        _SocialMediaButton(
          icon: _InstagramIcon(size: iconSize),
          label: 'Instagram',
          url: 'https://www.instagram.com/byletytravels.ok/',
          color: const Color(0xFFE4405F),
          showLabel: showLabels,
          iconColor: iconColor,
        ),
        SizedBox(width: spacing),
        _SocialMediaButton(
          icon: _TikTokIcon(size: iconSize),
          label: 'TikTok',
          url: 'https://www.tiktok.com/@byletytravels.ok',
          color: Colors.black,
          showLabel: showLabels,
          iconColor: iconColor,
        ),
      ],
    );
  }
}

/// Botón individual de red social con animación hover
class _SocialMediaButton extends StatefulWidget {
  final Widget icon;
  final String label;
  final String url;
  final Color color;
  final bool showLabel;
  final Color? iconColor;

  const _SocialMediaButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
    this.showLabel = false,
    this.iconColor,
  });

  @override
  State<_SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<_SocialMediaButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('No se pudo abrir: ${widget.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showLabel) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: _launchUrl,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color:
                  _isHovered
                      ? widget.color.withOpacity(0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered ? widget.color : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.icon,
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _isHovered ? widget.color : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Solo icono sin label
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.label,
        child: InkWell(
          onTap: _launchUrl,
          borderRadius: BorderRadius.circular(50),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  _isHovered
                      ? widget.color.withOpacity(0.1)
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: AnimatedScale(
              scale: _isHovered ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}

/// Icono de Facebook personalizado
class _FacebookIcon extends StatelessWidget {
  final double size;

  const _FacebookIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.facebook, size: size, color: const Color(0xFF1877F2));
  }
}

/// Icono de Instagram con gradiente
class _InstagramIcon extends StatelessWidget {
  final double size;

  const _InstagramIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => const LinearGradient(
            colors: [Color(0xFFFD5949), Color(0xFFD6249F), Color(0xFF285AEB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
      child: Icon(Icons.camera_alt_rounded, size: size, color: Colors.white),
    );
  }
}

/// Icono de TikTok
class _TikTokIcon extends StatelessWidget {
  final double size;

  const _TikTokIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Nota musical como representación de TikTok
        Icon(Icons.music_note, size: size, color: Colors.black),
      ],
    );
  }
}

/// Widget compacto para navbar
class SocialMediaLinksCompact extends StatelessWidget {
  const SocialMediaLinksCompact({super.key});

  @override
  Widget build(BuildContext context) {
    return const SocialMediaLinks(
      iconSize: 24,
      showLabels: false,
      alignment: MainAxisAlignment.end,
      spacing: 12,
    );
  }
}

/// Widget expandido para footer
class SocialMediaLinksExpanded extends StatelessWidget {
  final bool vertical;

  const SocialMediaLinksExpanded({super.key, this.vertical = false});

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Síguenos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildSocialButton(
            context,
            icon: const _FacebookIcon(size: 24),
            label: 'Facebook',
            url: 'https://www.facebook.com/profile.php?id=61575652439979',
          ),
          const SizedBox(height: 12),
          _buildSocialButton(
            context,
            icon: const _InstagramIcon(size: 24),
            label: 'Instagram',
            url: 'https://www.instagram.com/byletytravels.ok/',
          ),
          const SizedBox(height: 12),
          _buildSocialButton(
            context,
            icon: const _TikTokIcon(size: 24),
            label: 'TikTok',
            url: 'https://www.tiktok.com/@byletytravels.ok',
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Síguenos en Redes Sociales',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        const SocialMediaLinks(iconSize: 32, showLabels: false, spacing: 20),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required Widget icon,
    required String label,
    required String url,
  }) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
