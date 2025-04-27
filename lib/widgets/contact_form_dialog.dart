import 'package:event_management/screens/booking_success_screen.dart';
import 'package:event_management/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:event_management/utils/order_id_generator.dart';

import 'package:shared_preferences/shared_preferences.dart';


class ContactFormDialog extends StatefulWidget {
  final String serviceName;

  const ContactFormDialog({
    Key? key,
    required this.serviceName,
  }) : super(key: key);

  @override
  State<ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  final _formKey = GlobalKey<FormState>();
  String _selectedFunction = 'Wedding';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();
  DateTime? _selectedDate;

  // Add email validation regex
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  // Add phone validation regex for Indian numbers
  final RegExp _phoneRegex = RegExp(
    r'^[6-9]\d{9}$',  // Validates Indian mobile numbers
  );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _guestsController.dispose();
    super.dispose();
  }

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
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Contact Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
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
                          child: _buildFormFields(),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Function Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
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
                            children: [
                              _buildRadioTile('Pre- wedding'),
                              _buildRadioTile('Wedding'),
                              _buildRadioTile('Other celebrations'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24.0),
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
        child: ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Check availability',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: validator,
    );
  }

  Widget _buildRadioTile(String title) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.white70,
      ),
      child: RadioListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        value: title,
        groupValue: _selectedFunction,
        onChanged: (value) {
          setState(() {
            _selectedFunction = value.toString();
          });
        },
        activeColor: Colors.white,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  // Update the form fields with validators
  Column _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          controller: _nameController,
          label: 'Full Name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            if (value.length < 3) {
              return 'Name must be at least 3 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            if (!_phoneRegex.hasMatch(value)) {
              return 'Please enter a valid 10-digit mobile number';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildTextField(
          controller: _emailController,
          label: 'Email address',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!_emailRegex.hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildTextField(
          controller: _guestsController,
          label: 'No. of guests* (min 50)',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter number of guests';
            }
            if (int.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            if (int.parse(value) < 50) {
              return 'Minimum 50 guests required';
            }
            if (int.parse(value) > 1000) {
              return 'Maximum 1000 guests allowed';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedDate == null 
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate == null
                      ? 'Select Event Date'
                      : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(Icons.calendar_today, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8A2BE2),
              surface: Color(0xFF4A148C),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Button text color
              ),
            ),
            dialogBackgroundColor: Color(0xFF4A148C), // Dialog background
          ),
          child: child!,
        );
      },
      confirmText: "OK",
      cancelText: "Cancel",
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an event date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          },
        );

        // Get current user ID from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final userId = prefs.getString('userId');

        if (userId == null) {
          Navigator.pop(context); // Remove loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please login to make a booking'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final orderId = OrderIdGenerator.generate();

        // Create booking data
        final bookingData = {
          'orderId': orderId,
          'serviceName': widget.serviceName,
          'name': _nameController.text,
          'phone': _phoneController.text,
          'email': _emailController.text,
          'guests': int.parse(_guestsController.text),
          'functionType': _selectedFunction,
          'eventDate': '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
          'status': 'Pending',
          'createdAt': DateTime.now().toIso8601String(),
        };

        // Get service data from the widget
        final serviceData = {
          'id': orderId,
          'name': widget.serviceName,
          // Add these lines to include images
          'image1': 'assets/images/venue6.jpg',
          'image2': 'assets/images/venue7.jpg',
          'image3': 'assets/images/venue8.jpg',
        };

        // Save booking using FirebaseService
        final result = await FirebaseService().saveBooking(
          userId,
          serviceData,
          bookingData,
        );

        // Remove loading indicator
        Navigator.pop(context);

        if (result['success']) {
          // Navigate to success screen with booking data
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BookingSuccessScreen(
                orderId: orderId,
                bookingData: {
                  ...bookingData,
                  ...serviceData,
                },
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Remove loading indicator
        Navigator.pop(context);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 