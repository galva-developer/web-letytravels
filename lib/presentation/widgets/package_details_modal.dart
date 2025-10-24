import 'package:flutter/material.dart';
import 'package:by_lety_travels/data/models/package_travel.dart';
import 'package:by_lety_travels/presentation/pages/booking_form_page.dart';
import 'package:url_launcher/url_launcher.dart';

// Modal dialog to display detailed package information with tabs
class PackageDetailsModal extends StatefulWidget {
  final PackageTravel package;

  const PackageDetailsModal({super.key, required this.package});

  @override
  State<PackageDetailsModal> createState() => _PackageDetailsModalState();
}

class _PackageDetailsModalState extends State<PackageDetailsModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 20 : 40,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 800),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildHeader(isMobile),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildGalleryTab(),
                  _buildItineraryTab(),
                  _buildIncludedTab(),
                  _buildMapTab(),
                ],
              ),
            ),
            _buildFooter(isMobile),
          ],
        ),
      ),
    );
  }

  // Build modal header with title, close and share buttons
  Widget _buildHeader(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF072A47),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.package.title,
                  style: TextStyle(
                    color: const Color(0xFFFFDC00),
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white70,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.package.location,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Share button
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: _sharePackage,
            tooltip: 'Share',
          ),
          // Close button
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  // Build tab bar for navigation
  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF072A47),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFFFFDC00),
        indicatorWeight: 3,
        tabs: const [
          Tab(icon: Icon(Icons.photo_library), text: 'Galería'),
          Tab(icon: Icon(Icons.map), text: 'Itinerario'),
          Tab(icon: Icon(Icons.check_circle_outline), text: 'Incluido'),
          Tab(icon: Icon(Icons.location_on), text: 'Mapa'),
        ],
      ),
    );
  }

  // Gallery Tab - Image carousel with thumbnails
  Widget _buildGalleryTab() {
    final images =
        widget.package.galleryImages.isNotEmpty
            ? widget.package.galleryImages
            : [
              widget.package.imageUrl ?? 'https://via.placeholder.com/800x600',
            ];

    return Column(
      children: [
        // Main image
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(images[_selectedImageIndex]),
                fit: BoxFit.contain,
              ),
            ),
            child: Stack(
              children: [
                // Previous button
                if (images.length > 1)
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedImageIndex =
                                (_selectedImageIndex - 1 + images.length) %
                                images.length;
                          });
                        },
                      ),
                    ),
                  ),
                // Next button
                if (images.length > 1)
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedImageIndex =
                                (_selectedImageIndex + 1) % images.length;
                          });
                        },
                      ),
                    ),
                  ),
                // Image counter
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_selectedImageIndex + 1} / ${images.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Thumbnail strip
        if (images.length > 1)
          Container(
            height: 100,
            padding: const EdgeInsets.all(8),
            color: const Color(0xFFF5F5F5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedImageIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isSelected
                                ? const Color(0xFFFFDC00)
                                : Colors.transparent,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // Itinerary Tab - Day-by-day schedule
  Widget _buildItineraryTab() {
    final itinerary = widget.package.itinerary;

    if (itinerary.isEmpty) {
      return const Center(child: Text('Detalles del itinerario próximamente'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: itinerary.length,
      itemBuilder: (context, index) {
        final day = itinerary[index];
        return _buildDayCard(day, index);
      },
    );
  }

  // Build a single day card in itinerary
  Widget _buildDayCard(DayItinerary day, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: index == 0,
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF072A47),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Día\n${day.dayNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFFDC00),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(
            day.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle:
              day.meals.isNotEmpty
                  ? Row(
                    children: [
                      const Icon(
                        Icons.restaurant,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(day.meals, style: const TextStyle(fontSize: 12)),
                    ],
                  )
                  : null,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    day.activities.map((activity) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF072A47),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                activity,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Included/Excluded Tab
  Widget _buildIncludedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Package overview
          _buildOverviewCard(),
          const SizedBox(height: 20),

          // Inclusions
          _buildSection(
            title: 'Qué Incluye',
            icon: Icons.check_circle,
            iconColor: Colors.green,
            items:
                widget.package.inclusions.isNotEmpty
                    ? widget.package.inclusions
                    : ['Detalles del paquete próximamente'],
          ),
          const SizedBox(height: 20),

          // Exclusions
          _buildSection(
            title: 'Qué No Incluye',
            icon: Icons.cancel,
            iconColor: Colors.red,
            items:
                widget.package.exclusions.isNotEmpty
                    ? widget.package.exclusions
                    : ['Ver términos y condiciones'],
          ),
          const SizedBox(height: 20),

          // Terms and Conditions
          if (widget.package.termsAndConditions.isNotEmpty) _buildTermsCard(),
        ],
      ),
    );
  }

  // Build overview card with price and basic info
  Widget _buildOverviewCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Precio por persona',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    if (widget.package.hasDiscount &&
                        widget.package.originalPrice != null)
                      Text(
                        '\$${widget.package.originalPrice!.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 2,
                        ),
                      ),
                    Text(
                      widget.package.price,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                if (widget.package.hasDiscount &&
                    widget.package.discountPercentage != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.package.discountPercentage}% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(Icons.access_time, widget.package.duration),
            _buildInfoRow(Icons.hotel, '${widget.package.hotelRating} Hotel'),
            if (widget.package.flightsIncluded)
              _buildInfoRow(Icons.flight, 'Flights Included'),
            if (widget.package.guidedTours)
              _buildInfoRow(Icons.tour, 'Guided Tours'),
          ],
        ),
      ),
    );
  }

  // Build info row with icon and text
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF072A47)),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Build section with list of items
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children:
                  items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(icon, color: iconColor, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Build terms and conditions card
  Widget _buildTermsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: const Icon(Icons.description, color: Color(0xFF072A47)),
          title: const Text(
            'Términos y Condiciones',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.package.termsAndConditions,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Map Tab - Show location
  Widget _buildMapTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Map placeholder
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Placeholder for Google Maps
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        widget.package.location,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lat: ${widget.package.latitude.toStringAsFixed(4)}, '
                        'Lng: ${widget.package.longitude.toStringAsFixed(4)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _openGoogleMaps,
                        icon: const Icon(Icons.directions),
                        label: const Text('Get Directions'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF072A47),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Available dates
          if (widget.package.availableDates.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fechas Disponibles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      widget.package.availableDates.map((date) {
                        return Chip(
                          avatar: const Icon(Icons.calendar_today, size: 16),
                          label: Text(
                            '${date.day}/${date.month}/${date.year}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          backgroundColor: const Color(0xFFF5F5F5),
                        );
                      }).toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // Build footer with action buttons
  Widget _buildFooter(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child:
          isMobile
              ? Column(
                children: [
                  _buildBookNowButton(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildWhatsAppButton()),
                      const SizedBox(width: 8),
                      Expanded(child: _buildEmailButton()),
                    ],
                  ),
                ],
              )
              : Row(
                children: [
                  Expanded(child: _buildWhatsAppButton()),
                  const SizedBox(width: 12),
                  Expanded(child: _buildEmailButton()),
                  const SizedBox(width: 12),
                  Expanded(flex: 2, child: _buildBookNowButton()),
                ],
              ),
    );
  }

  // WhatsApp button
  Widget _buildWhatsAppButton() {
    return OutlinedButton.icon(
      onPressed: _contactViaWhatsApp,
      icon: const Icon(Icons.chat, size: 20),
      label: const Text('WhatsApp'),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF25D366),
        side: const BorderSide(color: Color(0xFF25D366), width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  // Email button
  Widget _buildEmailButton() {
    return OutlinedButton.icon(
      onPressed: _contactViaEmail,
      icon: const Icon(Icons.email, size: 20),
      label: const Text('Email'),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF072A47),
        side: const BorderSide(color: Color(0xFF072A47), width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  // Book Now button
  Widget _buildBookNowButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Close the modal
        Navigator.of(context).pop();

        // Navigate to booking form page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookingFormPage(package: widget.package),
          ),
        );
      },
      icon: const Icon(Icons.flight_takeoff, size: 20),
      label: const Text('Reservar'),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF072A47),
        backgroundColor: const Color(0xFFFFDC00),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  // Contact via WhatsApp
  void _contactViaWhatsApp() async {
    final message =
        'Hi! I\'m interested in the ${widget.package.title} package';
    final whatsappUrl =
        'https://wa.me/5493884102859?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  // Contact via Email
  void _contactViaEmail() async {
    final emailUrl =
        'mailto:byletytravels.oficial@gmail.com?subject=${Uri.encodeComponent('Inquiry: ${widget.package.title}')}&body=${Uri.encodeComponent('I would like more information about this package.')}';

    if (await canLaunchUrl(Uri.parse(emailUrl))) {
      await launchUrl(Uri.parse(emailUrl));
    }
  }

  // Share package
  void _sharePackage() {
    // TODO: Implement share functionality with share_plus package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de compartir próximamente!')),
    );
  }

  // Open Google Maps
  void _openGoogleMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.package.latitude},${widget.package.longitude}';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
