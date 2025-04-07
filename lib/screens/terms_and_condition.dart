import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 72, 20, 72).withOpacity(0.9),
              const Color(0xFF4A148C).withOpacity(0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection(
                          'Last Updated: March 15, 2024',
                          'Please read these terms and conditions carefully before using our services.',
                        ),
                        _buildSection(
                          '1. Acceptance of Terms',
                          'By accessing and using the Red Carpet Event Management application, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.',
                        ),
                        _buildSection(
                          '2. User Registration',
                          '• Users must provide accurate and complete information\n'
                          '• Users are responsible for maintaining account security\n'
                          '• Users must be at least 18 years old to use our services\n'
                          '• Account sharing is not permitted',
                        ),
                        _buildSection(
                          '3. Booking and Payments',
                          '• All bookings are subject to availability\n'
                          '• Full payment is required to confirm bookings\n'
                          '• Prices are subject to change without notice\n'
                          '• Additional charges may apply for special requests\n'
                          '• All prices are inclusive of applicable taxes',
                        ),
                        _buildSection(
                          '4. Cancellation Policy',
                          '• Cancellations must be made 48 hours in advance\n'
                          '• Refunds will be processed within 7-10 business days\n'
                          '• Cancellation fees may apply\n'
                          '• Rescheduling is subject to availability',
                        ),
                        _buildSection(
                          '5. Service Delivery',
                          '• We guarantee professional service delivery\n'
                          '• All vendors are verified and qualified\n'
                          '• Quality standards are regularly monitored\n'
                          '• Service timing will be strictly followed',
                        ),
                        _buildSection(
                          '6. User Responsibilities',
                          '• Provide accurate event details\n'
                          '• Maintain proper communication\n'
                          '• Respect venue rules and regulations\n'
                          '• Report any issues promptly',
                        ),
                        _buildSection(
                          '7. Liability',
                          '• We are not liable for circumstances beyond our control\n'
                          '• Damage to venue or equipment will be charged\n'
                          '• Insurance is recommended for large events\n'
                          '• Personal belongings are user\'s responsibility',
                        ),
                        _buildSection(
                          '8. Privacy Policy',
                          '• We collect and process personal data securely\n'
                          '• Information is never shared with third parties\n'
                          '• Users can request data deletion\n'
                          '• Cookies are used to improve user experience',
                        ),
                        _buildSection(
                          '9. Intellectual Property',
                          '• All content is protected by copyright\n'
                          '• Users cannot reproduce content without permission\n'
                          '• Event photos may be used for promotion\n'
                          '• Brand names and logos are protected',
                        ),
                        _buildSection(
                          '10. Modifications',
                          'We reserve the right to modify these terms at any time. Users will be notified of significant changes.',
                        ),
                        _buildSection(
                          '11. Governing Law',
                          'These terms are governed by the laws of India. Any disputes will be subject to the exclusive jurisdiction of courts in Bangalore.',
                        ),
                        _buildSection(
                          '12. Contact Information',
                          'For any questions about these terms, please contact us at:\n'
                          'Email: support@redcarpet.com\n'
                          'Phone: +91 9876543210\n'
                          'Address: Bangalore, India',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
