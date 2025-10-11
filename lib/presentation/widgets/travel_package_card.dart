import 'package:flutter/material.dart';

// A widget to display travel package information in a card format.
class TravelPackageCard extends StatelessWidget {
  final String title;
  final String price;
  final String location;
  final String description;
  final String duration;
  final bool flightsIncluded;
  final String hotelRating;
  final bool guidedTours;
  final String? imageUrl; // Optional: URL for the package image
  final VoidCallback? onBookNowPressed; // Callback for the book now button

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
    this.imageUrl, // Added imageUrl to the constructor
    this.onBookNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Adds a shadow to the card
      margin: const EdgeInsets.all(16.0), // Margin around the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12.0,
        ), // Rounded corners for the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns children to the start (left)
          children: <Widget>[
            // Top section: Title and Price
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween, // Puts space between title and price
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Handles long titles
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Price color
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0), // Spacing
            // Image section
            if (imageUrl != null && imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl!,
                  height: 180.0,
                  width: double.infinity, // Make image take full card width
                  fit: BoxFit.cover,
                  // Optional: Show a placeholder while loading
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
                  // Optional: Show an error icon if the image fails to load
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) {
                    return Container(
                      height: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              )
            else
              // Placeholder if no image URL is provided or if it's empty
              Container(
                height: 180.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Placeholder color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey[600],
                ), // Placeholder icon
              ),
            const SizedBox(height: 12.0),

            // Location
            Text(
              location,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8.0),

            // Description
            Text(description, style: const TextStyle(fontSize: 14.0)),
            const SizedBox(height: 16.0),

            // Details section
            _buildDetailRow(Icons.calendar_today, duration),
            if (flightsIncluded)
              _buildDetailRow(Icons.flight, 'Flights included'),
            _buildDetailRow(Icons.hotel, '$hotelRating hotel'),
            if (guidedTours)
              _buildDetailRow(Icons.directions_walk, 'Guided tours'),

            const SizedBox(height: 20.0),

            // Book Now Button
            Center(
              // Centers the button
              child: ElevatedButton(
                onPressed:
                    onBookNowPressed ??
                    () {
                      // Default action if no callback is provided
                      print('Book Now pressed for: $title');
                    },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 15.0,
                  ),
                  textStyle: const TextStyle(fontSize: 16.0),
                ),
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build a row for package details (e.g., duration, flights)
  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 18.0, color: Colors.blueGrey),
          const SizedBox(width: 8.0),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14.0))),
        ],
      ),
    );
  }
}
