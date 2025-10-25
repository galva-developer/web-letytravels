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
      'https://scontent-mad2-1.xx.fbcdn.net/v/t39.30808-6/519682400_122131471310855081_1039629237109151148_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=833d8c&_nc_ohc=Lk1xFzw-lKQQ7kNvwGcA60Y&_nc_oc=AdlsE8XuangdTuhOTA8q6XwrjGvLbapSF6rvE2HYR8dpeOPqNy97wYF87hYYhC81c9K-iiqMUrz1awX0qy0Ssst4&_nc_zt=23&_nc_ht=scontent-mad2-1.xx&_nc_gid=_xC09Qjz5ehBbhEPs4sjdw&oh=00_AfeDmTjPf0VX6AWx2Sd9t1ohAzKc4AdtvBc_bGVsy4oPcA&oe=6903116C',
      'https://scontent-mad2-1.xx.fbcdn.net/v/t39.30808-6/519415425_122131471208855081_997845402250862449_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_ohc=yHnFzp88p5MQ7kNvwFaysHr&_nc_oc=AdkLJlDoMUK_HlFvawXNWNulOja17D6xJK-PEUM595cb15jXi7YPZj4-iyBHFXhZGKvm9nXMcY4J3EUB7OMOx7kh&_nc_zt=23&_nc_ht=scontent-mad2-1.xx&_nc_gid=__vqOx_0IzcDxsy_lnvh7A&oh=00_AfdRhugTq5RE0O_qVHqcNVGK65pBEyNoC88HxfAwBTJj3A&oe=69032851',
      'https://scontent-mad2-1.xx.fbcdn.net/v/t39.30808-6/509331041_122123007164855081_6102273974423257564_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=833d8c&_nc_ohc=N-uyJvIcu74Q7kNvwG_HMSN&_nc_oc=AdnMd7sFQ-qqiTT3rQ_8lN0WUrnl9d9nUfUNkgsfUJ6oUyQbk7jRvqAHXRyHgnQ9UIEnuDnTwRUYlvGu5KJ-3_0T&_nc_zt=23&_nc_ht=scontent-mad2-1.xx&_nc_gid=jsk3TV_D2ocrbh53tmuyeA&oh=00_AfdJUNPsEILRvub8ibFTAcmi0Uh_7Ut2dYtl6BHNhk1-Dw&oe=690301C9',
      'https://scontent-mad2-1.xx.fbcdn.net/v/t39.30808-6/520306246_122131466918855081_5025052199899484492_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_ohc=D0ZKRU6xG_EQ7kNvwH3Iv7i&_nc_oc=AdnXlV1ZEgKoSljEQgD7AzgZSYVFvhui5UWRIlLrmqd4orSTneLGxF08G77nq5rS45q5Ie03Zo3f3-FyTOlMlM4g&_nc_zt=23&_nc_ht=scontent-mad2-1.xx&_nc_gid=qRPpaSobDHC4V28C7C_E2g&oh=00_Afd_42dVvixzmPV2lJnVV0OV2OCkAs4Z7mfQ-GpY5ncnhg&oe=69030CB5',
      'https://scontent-mad1-1.xx.fbcdn.net/v/t39.30808-6/509367279_122123003828855081_7307789903672535_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_ohc=VMqHC0KDFQcQ7kNvwGFZiWs&_nc_oc=Adl98A4afE9lhqmKDOiy0wfnRNHcSKsEbMDZjp1Ql7IGxpnfu2SJF6QhO_0kdnQ-q_Glg-iaRtvFEBlaZHJqLJjU&_nc_zt=23&_nc_ht=scontent-mad1-1.xx&_nc_gid=4Wmo7d2DwKiRc-ddQDErIQ&oh=00_AfdtTVNweZ9cZmlUIiVN5lMgDgW19jqUnTlIrn_-hsnHlw&oe=6903103F',
      'https://scontent-mad1-1.xx.fbcdn.net/v/t39.30808-6/509423995_122123004950855081_7710483682074799878_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_ohc=1xm7kaVEiKgQ7kNvwFx2z1T&_nc_oc=Admg0dIOp1Abxs62QALDh_rNnHTfpnqHFVUzlbbq61F-IPhSurU1gVm4q2AyiVAV9GLfEC6N8bw-2cqrzO4MTZFZ&_nc_zt=23&_nc_ht=scontent-mad1-1.xx&_nc_gid=qvTPwPZz8tk2hS-gJszvog&oh=00_AffTFhuw1ilSytmuVJxverCxuPjSdNgHfDmXsqnzwcrPjA&oe=69030C99',
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
