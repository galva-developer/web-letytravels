import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget que muestra un feed de Instagram con las últimas publicaciones
///
/// Nota: En producción, se debería usar la Instagram Basic Display API
/// para obtener las publicaciones reales. Esta implementación muestra
/// publicaciones de ejemplo con imágenes placeholder.
class InstagramFeed extends StatelessWidget {
  final GlobalKey? sectionKey;
  final String instagramUsername;
  final String instagramUrl;
  final int numberOfPosts;

  const InstagramFeed({
    super.key,
    this.sectionKey,
    this.instagramUsername = 'byletytravels.ok',
    this.instagramUrl = 'https://www.instagram.com/byletytravels.ok/',
    this.numberOfPosts = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: [
          // Título de la sección
          _buildHeader(context),
          const SizedBox(height: 40),

          // Grid de publicaciones
          _buildPostsGrid(context),
          const SizedBox(height: 32),

          // Botón para ver más en Instagram
          _buildViewProfileButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Icono de Instagram con gradiente
        ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [
                  Color(0xFFFD5949),
                  Color(0xFFD6249F),
                  Color(0xFF285AEB),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
          child: const Icon(
            Icons.camera_alt_rounded,
            size: 48,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        // Título
        const Text(
          'Síguenos en Instagram',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        // Subtítulo con username
        GestureDetector(
          onTap: () => _openInstagram(),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '@$instagramUsername',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFE4405F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Color(0xFFE4405F),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Descubre nuestras últimas aventuras y destinos',
          style: TextStyle(fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPostsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determinar número de columnas según el ancho
        int crossAxisCount = 3;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 900) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 6;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: numberOfPosts,
          itemBuilder: (context, index) {
            return _InstagramPostCard(
              imageUrl: _getPlaceholderImage(index),
              postUrl: instagramUrl,
              index: index,
            );
          },
        );
      },
    );
  }

  Widget _buildViewProfileButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _openInstagram(),
      icon: const Icon(Icons.camera_alt_rounded),
      label: const Text('Ver más en Instagram'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE4405F),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 2,
      ),
    );
  }

  Future<void> _openInstagram() async {
    final uri = Uri.parse(instagramUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // Método helper para obtener imágenes placeholder
  // En producción, esto vendría de la API de Instagram
  String _getPlaceholderImage(int index) {
    final List<String> placeholderImages = [
      'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400&h=400&fit=crop', // París
      'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?w=400&h=400&fit=crop', // Maldivas
      'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=400&h=400&fit=crop', // Santorini
      'https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b?w=400&h=400&fit=crop', // Viajar
      'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=400&h=400&fit=crop', // Lago
      'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400&h=400&fit=crop', // Aventura
    ];

    return placeholderImages[index % placeholderImages.length];
  }
}

/// Card individual para cada publicación de Instagram
class _InstagramPostCard extends StatefulWidget {
  final String imageUrl;
  final String postUrl;
  final int index;

  const _InstagramPostCard({
    required this.imageUrl,
    required this.postUrl,
    required this.index,
  });

  @override
  State<_InstagramPostCard> createState() => _InstagramPostCardState();
}

class _InstagramPostCardState extends State<_InstagramPostCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _openPost(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow:
                _isHovered
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Imagen de la publicación
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                        ),
                      ),
                    );
                  },
                ),

                // Overlay al hacer hover
                if (_isHovered)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.3),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback:
                                (bounds) => const LinearGradient(
                                  colors: [
                                    Color(0xFFFD5949),
                                    Color(0xFFD6249F),
                                    Color(0xFF285AEB),
                                  ],
                                ).createShader(bounds),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Ver en Instagram',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openPost() async {
    final uri = Uri.parse(widget.postUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Variante compacta del feed para usar en otras secciones
class InstagramFeedCompact extends StatelessWidget {
  const InstagramFeedCompact({super.key});

  @override
  Widget build(BuildContext context) {
    return const InstagramFeed(numberOfPosts: 4);
  }
}
