import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> booking;
  final Color primaryPurple = const Color(0xFF8A2BE2);

  const BookingDetailsScreen({
    Key? key,
    required this.booking,
  }) : super(key: key);

  Color _getStatusColor(String? status) {
    // Using different shades of purple for status
    switch (status) {
      case 'Confirmed':
        return primaryPurple;
      case 'Pending':
        return primaryPurple.withOpacity(0.7);
      case 'Completed':
        return primaryPurple;
      case 'Cancelled':
        return primaryPurple.withOpacity(0.5);
      default:
        return primaryPurple.withOpacity(0.3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryPurple.withOpacity(0.9),
        title: Text(
          booking['serviceName'] ?? 'Booking Details',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            SizedBox(
              height: 200,
              child: PageView(
                children: [
                  _buildImageContainer(booking['image1']),
                  _buildImageContainer(booking['image2']),
                  _buildImageContainer(booking['image3']),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(booking['status']).withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      booking['status'] ?? 'Unknown',
                      style: TextStyle(
                        color: _getStatusColor(booking['status']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Service Name
                  Text(
                    booking['serviceName'] ?? 'No Service Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryPurple,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Booking Information Section
                  _buildDetailSection('Booking Information', [
                    _buildDetailRow('Event Date', booking['eventDate'] ?? 'Not specified'),
                    _buildDetailRow('Number of Guests', '${booking['guests']?.toString() ?? '0'} people'),
                    _buildDetailRow('Booked By', booking['name'] ?? 'Not specified'),
                  ]),
                  const SizedBox(height: 24),

                  // Cancel Button for Pending/Confirmed bookings
                  if (booking['status'] == 'Pending' || booking['status'] == 'Confirmed')
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () => _showCancelDialog(context),
                        child: const Text(
                          'Cancel Booking',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer(String? imageUrl) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: primaryPurple.withOpacity(0.1),
        image: imageUrl != null
            ? DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Icon(Icons.image_not_supported, 
              size: 50, 
              color: primaryPurple.withOpacity(0.3))
          : null,
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryPurple,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: primaryPurple.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: primaryPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Cancel Booking',
          style: TextStyle(color: primaryPurple),
        ),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'No',
              style: TextStyle(color: primaryPurple.withOpacity(0.7)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Booking cancelled successfully'),
                  backgroundColor: primaryPurple,
                ),
              );
            },
            child: Text(
              'Yes',
              style: TextStyle(color: primaryPurple),
            ),
          ),
        ],
      ),
    );
  }
} 