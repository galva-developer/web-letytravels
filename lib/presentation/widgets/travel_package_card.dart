import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:by_lety_travels/presentation/providers/favorites_provider.dart';

// Enhanced widget to display travel package information in a card format with badges and flip animation.
class TravelPackageCard extends StatefulWidget {
  final String title;
  final String price;
  final String location;
  final String description;
  final String duration;
  final bool flightsIncluded;
  final String hotelRating;
  final bool guidedTours;
  final String? imageUrl;
  final VoidCallback? onBookNowPressed;
  final VoidCallback? onViewDetailsPressed;

  // Badge and discount properties
  final bool hasDiscount;
  final String? originalPrice;
  final int? discountPercentage;
  final bool isNew;
  final bool isPopular;
  final bool hasLimitedSeats;
  final int? availableSeats;
  final List<String> services;

  const TravelPackageCard({
    super.key,
    required this.title,
    required this.price,
    required this.location,
    required this.description,
    required this.duration,
    required this.flightsIncluded,
    required this.hotelRating,
    required this.guidedTours,
    this.imageUrl,
    this.onBookNowPressed,
    this.onViewDetailsPressed,
    this.hasDiscount = false,
    this.originalPrice,
    this.discountPercentage,
    this.isNew = false,
    this.isPopular = false,
    this.hasLimitedSeats = false,
    this.availableSeats,
    this.services = const [],
  });

  @override
  State<TravelPackageCard> createState() => _TravelPackageCardState();
}

class _TravelPackageCardState extends State<TravelPackageCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFlipped = false; // Track if card is currently flipped
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    // If mouse exits card completely, reset flip
    if (!isHovered && _isFlipped) {
      setState(() => _isFlipped = false);
      _flipController.reverse();
    }
  }

  // Handle flip animation - triggered by image hover or click
  void _handleFlipHover(bool shouldFlip) {
    if (shouldFlip && !_isFlipped) {
      setState(() => _isFlipped = true);
      _flipController.forward();
    }
  }

  // Toggle flip state on click
  void _toggleFlip() {
    setState(() => _isFlipped = !_isFlipped);
    if (_isFlipped) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final angle = _flipAnimation.value * math.pi;
          final transform =
              Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(angle);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
            child: Transform(
              transform: transform,
              alignment: Alignment.center,
              child:
                  angle <= math.pi / 2
                      ? _buildFrontCard(context)
                      : Transform(
                        transform: Matrix4.rotationY(math.pi),
                        alignment: Alignment.center,
                        child: _buildBackCard(context),
                      ),
            ),
          );
        },
      ),
    );
  }

  /// Build the front side of the card (original design)
  Widget _buildFrontCard(BuildContext context) {
    return Card(
      elevation: _isHovered ? 12.0 : 4.0,
      margin: const EdgeInsets.all(16.0),
      color: const Color(0xFFF5F5F5), // Fondo gris claro
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image section with badges overlay
              _buildImageSection(),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Price
                    _buildTitleAndPrice(),
                    const SizedBox(height: 8.0),

                    // Location
                    Text(
                      widget.location,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Description
                    Text(
                      widget.description,
                      style: const TextStyle(fontSize: 14.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16.0),

                    // Services icons (more visible)
                    _buildServicesIcons(),
                    const SizedBox(height: 16.0),

                    // Details section
                    _buildDetailRow(Icons.calendar_today, widget.duration),
                    if (widget.flightsIncluded)
                      _buildDetailRow(Icons.flight, 'Flights included'),
                    _buildDetailRow(Icons.hotel, '${widget.hotelRating} hotel'),
                    if (widget.guidedTours)
                      _buildDetailRow(Icons.directions_walk, 'Guided tours'),

                    const SizedBox(height: 20.0),

                    // Action buttons
                    _buildActionButtons(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build favorite button widget
  Widget _buildFavoriteButton() {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite = favoritesProvider.isFavorite(widget.title);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              await favoritesProvider.toggleFavorite(widget.title);
            },
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey[600],
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build the back side of the card (detailed info)
  Widget _buildBackCard(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFlip, // Click to flip back to front
      child: Card(
        elevation: _isHovered ? 12.0 : 4.0,
        margin: const EdgeInsets.all(16.0),
        color: const Color(0xFF072A47), // Azul oscuro para el reverso
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24.0,
                56.0,
                24.0,
                24.0,
              ), // Extra top padding to avoid checkbox overlap
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFDC00),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  Container(
                    height: 2,
                    width: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFDC00), Colors.transparent],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Detailed Information
                  _buildBackInfoRow(
                    Icons.location_on,
                    widget.location,
                    'Destino',
                  ),
                  const SizedBox(height: 12),
                  _buildBackInfoRow(
                    Icons.calendar_today,
                    widget.duration,
                    'Duración',
                  ),
                  const SizedBox(height: 12),
                  _buildBackInfoRow(
                    Icons.attach_money,
                    widget.price,
                    'Precio por persona',
                  ),
                  const SizedBox(height: 12),
                  _buildBackInfoRow(
                    Icons.hotel,
                    widget.hotelRating,
                    'Alojamiento',
                  ),
                  const SizedBox(height: 20),

                  // Features list
                  const Text(
                    'Incluye:',
                    style: TextStyle(
                      color: Color(0xFFFFDC00),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (widget.flightsIncluded)
                    _buildFeatureItem('✈️ Vuelos ida y vuelta'),
                  _buildFeatureItem('🏨 Alojamiento ${widget.hotelRating}'),
                  if (widget.guidedTours)
                    _buildFeatureItem('🎯 Tours guiados en español'),
                  if (widget.services.contains('Meals Included'))
                    _buildFeatureItem('🍽️ Comidas incluidas'),

                  const Spacer(),

                  // Call to Action
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: widget.onBookNowPressed,
                          icon: const Icon(Icons.check_circle, size: 20),
                          label: const Text('Reservar Ahora'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFDC00),
                            foregroundColor: const Color(0xFF072A47),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Click hint icon in top-right corner
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDC00).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.touch_app,
                  color: Color(0xFFFFDC00),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build info row for back card
  Widget _buildBackInfoRow(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFFDC00), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build feature item for back card
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  /// Build image section with badges
  Widget _buildImageSection() {
    return MouseRegion(
      onEnter: (_) => _handleFlipHover(true),
      onExit: (_) => _handleFlipHover(false),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            child:
                widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                    ? Image.network(
                      widget.imageUrl!,
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200.0,
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                          ),
                        );
                      },
                      errorBuilder: (context, exception, stackTrace) {
                        return Container(
                          height: 200.0,
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    )
                    : Container(
                      height: 200.0,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    ),
          ),

          // Badges overlay
          Positioned(
            top: 12,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.hasDiscount)
                  _buildBadge('OFERTA', Colors.red, Icons.local_offer),
                if (widget.isNew)
                  _buildBadge(
                    'NUEVO',
                    const Color(0xFF072A47),
                    Icons.fiber_new,
                  ),
                if (widget.isPopular)
                  _buildBadge(
                    'POPULAR',
                    const Color(0xFFFFDC00),
                    Icons.star,
                    textColor: const Color(0xFF072A47),
                  ),
                if (widget.hasLimitedSeats)
                  _buildBadge(
                    'ÚLTIMAS PLAZAS',
                    Colors.orange,
                    Icons.warning_amber,
                  ),
              ],
            ),
          ),

          // Discount percentage badge (top right)
          if (widget.hasDiscount && widget.discountPercentage != null)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '¡${widget.discountPercentage}% OFF!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build a badge widget
  Widget _buildBadge(
    String label,
    Color color,
    IconData icon, {
    Color textColor = Colors.white,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Build title and price section
  Widget _buildTitleAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF072A47),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Original price (crossed out if discount)
                if (widget.hasDiscount && widget.originalPrice != null)
                  Text(
                    widget.originalPrice!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2.0,
                    ),
                  ),
                // Current price (always green)
                Text(
                  widget.price,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            // Favorite button next to price
            _buildFavoriteButton(),
          ],
        ),
      ],
    );
  }

  /// Build services icons section
  Widget _buildServicesIcons() {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        if (widget.flightsIncluded)
          _buildServiceChip(Icons.flight, 'Vuelos', const Color(0xFF072A47)),
        if (widget.hotelRating.contains('5'))
          _buildServiceChip(
            Icons.hotel,
            'Hotel 5★',
            const Color(0xFFFFDC00),
            textColor: const Color(0xFF072A47),
          ),
        if (widget.guidedTours)
          _buildServiceChip(Icons.tour, 'Tours', const Color(0xFF072A47)),
        if (widget.services.contains('Meals Included'))
          _buildServiceChip(
            Icons.restaurant,
            'Comidas',
            const Color(0xFF072A47),
          ),
      ],
    );
  }

  /// Build a service chip
  Widget _buildServiceChip(
    IconData icon,
    String label,
    Color color, {
    Color textColor = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Build detail row
  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18.0, color: const Color(0xFF072A47)),
          const SizedBox(width: 8.0),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14.0))),
        ],
      ),
    );
  }

  /// Build action buttons
  Widget _buildActionButtons() {
    return Row(
      children: [
        // View Details button
        Expanded(
          child: OutlinedButton.icon(
            onPressed:
                widget.onViewDetailsPressed ??
                () {
                  print('View Details pressed for: ${widget.title}');
                },
            icon: const Icon(Icons.info_outline, size: 18),
            label: const Text('Ver Detalles'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF072A47),
              side: const BorderSide(color: Color(0xFF072A47), width: 2),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Book Now button
        Expanded(
          child: ElevatedButton.icon(
            onPressed:
                widget.onBookNowPressed ??
                () {
                  print('Book Now pressed for: ${widget.title}');
                },
            icon: const Icon(Icons.check_circle_outline, size: 18),
            label: const Text('Reservar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFDC00),
              foregroundColor: const Color(0xFF072A47),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: _isHovered ? 8 : 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
