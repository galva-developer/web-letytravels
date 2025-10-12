import 'package:flutter/material.dart';

// Enhanced widget to display travel package information in a card format with badges and animations.
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: Card(
          elevation: _isHovered ? 12.0 : 4.0,
          margin: const EdgeInsets.all(16.0),
          color: const Color(0xFFF5F5F5), // Fondo gris claro
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
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
                        _buildDetailRow(
                          Icons.hotel,
                          '${widget.hotelRating} hotel',
                        ),
                        if (widget.guidedTours)
                          _buildDetailRow(
                            Icons.directions_walk,
                            'Guided tours',
                          ),

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
        ),
      ),
    );
  }

  /// Build image section with badges
  Widget _buildImageSection() {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
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
                    child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
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
                _buildBadge('NUEVO', const Color(0xFF072A47), Icons.fiber_new),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
