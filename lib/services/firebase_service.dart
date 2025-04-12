import 'package:firebase_database/firebase_database.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  bool _isPasswordValid(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  // Sign Up User
  Future<Map<String, dynamic>> signUp(String fullName, String email, String password) async {
    try {
      if (!_isPasswordValid(password)) {
        return {
          'success': false,
          'message': 'Password must be at least 8 characters long and contain uppercase, lowercase, and numbers'
        };
      }

      // Check if email already exists
      final snapshot = await _database.child('users').orderByChild('email').equalTo(email).get();
      
      if (snapshot.exists) {
        return {
          'success': false,
          'message': 'Email already exists'
        };
      }

      // Create new user with plain password
      String userId = DateTime.now().millisecondsSinceEpoch.toString();
      await _database.child('users').child(userId).set({
        'fullName': fullName,
        'email': email,
        'password': password, // Store plain password
        'createdAt': ServerValue.timestamp,
      });

      return {
        'success': true,
        'userId': userId,
        'user': UserModel(
          id: userId,
          fullName: fullName,
          email: email,
        ),
        'message': 'Account created successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to create account: ${e.toString()}'
      };
    }
  }

  // Sign In User
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final snapshot = await _database.child('users').orderByChild('email').equalTo(email).get();

      if (!snapshot.exists) {
        return {
          'success': false,
          'message': 'User not found'
        };
      }

      Map<dynamic, dynamic> users = snapshot.value as Map;
      String? userId;
      Map<String, dynamic>? userData;

      users.forEach((key, value) {
        if (value['email'] == email && value['password'] == password) {
          userId = key;
          userData = Map<String, dynamic>.from(value);
        }
      });

      if (userId == null) {
        return {
          'success': false,
          'message': 'Invalid password'
        };
      }

      // Save user session with complete user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId!);
      await prefs.setString('userEmail', email);
      await prefs.setString('userName', userData!['fullName']); // Make sure to save the full name
      await prefs.setBool('isLoggedIn', true);

      print('Saved user data: ${userData!['fullName']}'); // Debug print

      return {
        'success': true,
        'userId': userId,
        'userData': userData,
        'message': 'Login successful'
      };
    } catch (e) {
      print('Login error: $e'); // Debug print
      return {
        'success': false,
        'message': 'Login failed: ${e.toString()}'
      };
    }
  }

  // Save Event Data
  Future<Map<String, dynamic>> saveEvent(String userId, Map<String, dynamic> eventData) async {
    try {
      String eventId = DateTime.now().millisecondsSinceEpoch.toString();
      await _database.child('events').child(eventId).set({
        ...eventData,
        'userId': userId,
        'createdAt': ServerValue.timestamp,
      });

      return {
        'success': true,
        'eventId': eventId,
        'message': 'Event saved successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to save event: ${e.toString()}'
      };
    }
  }

  // Update the resetPassword method
  Future<Map<String, dynamic>> resetPassword(String email, String newPassword) async {
    try {
      if (!_isPasswordValid(newPassword)) {
        return {
          'success': false,
          'message': 'Password must be at least 8 characters long and contain uppercase, lowercase, and numbers'
        };
      }

      final snapshot = await _database.child('users').orderByChild('email').equalTo(email).get();

      if (!snapshot.exists) {
        return {
          'success': false,
          'message': 'User not found'
        };
      }

      Map<dynamic, dynamic> users = snapshot.value as Map;
      String userId = users.keys.first;

      // Update with plain password
      await _database.child('users').child(userId).update({
        'password': newPassword,
        'updatedAt': ServerValue.timestamp,
      });

      return {
        'success': true,
        'message': 'Password updated successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to reset password: ${e.toString()}'
      };
    }
  }

  // Get user profile data
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final snapshot = await _database.child('users').child(userId).get();

      if (!snapshot.exists) {
        return {
          'success': false,
          'message': 'User profile not found'
        };
      }

      Map<dynamic, dynamic> userData = snapshot.value as Map;
      return {
        'success': true,
        'userData': Map<String, dynamic>.from(userData),
        'message': 'Profile fetched successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to fetch profile: ${e.toString()}'
      };
    }
  }

  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile(String userId, Map<String, dynamic> updateData) async {
    try {
      // Get current user data first
      final currentData = await _database.child('users').child(userId).get();
      
      if (!currentData.exists) {
        return {
          'success': false,
          'message': 'User not found'
        };
      }

      // Update only the provided fields
      await _database.child('users').child(userId).update({
        ...updateData,
        'updatedAt': ServerValue.timestamp,
      });

      // Update SharedPreferences if name is updated
      if (updateData.containsKey('fullName')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', updateData['fullName']);
      }

      return {
        'success': true,
        'message': 'Profile updated successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to update profile: ${e.toString()}'
      };
    }
  }

  // Get user bookings
  Future<Map<String, dynamic>> getUserBookings(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('bookings')
          .get();

      if (!snapshot.exists) {
        return {
          'success': true,
          'bookings': [],
          'message': 'No bookings found'
        };
      }

      Map<dynamic, dynamic> bookingsData = snapshot.value as Map;
      List<Map<String, dynamic>> bookings = [];
      
      bookingsData.forEach((key, value) {
        bookings.add(Map<String, dynamic>.from(value));
      });

      return {
        'success': true,
        'bookings': bookings,
        'message': 'Bookings fetched successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to fetch bookings: ${e.toString()}'
      };
    }
  }

  // Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Logout user
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all stored data
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  // Update user password
  Future<Map<String, dynamic>> updatePassword(String userId, String currentPassword, String newPassword) async {
    try {
      if (!_isPasswordValid(newPassword)) {
        return {
          'success': false,
          'message': 'New password must be at least 8 characters long and contain uppercase, lowercase, and numbers'
        };
      }

      // Get user data
      final snapshot = await _database.child('users').child(userId).get();
      
      if (!snapshot.exists) {
        return {
          'success': false,
          'message': 'User not found'
        };
      }

      Map<dynamic, dynamic> userData = snapshot.value as Map;
      
      // Verify current password (plain text comparison)
      if (userData['password'] != currentPassword) {
        return {
          'success': false,
          'message': 'Current password is incorrect'
        };
      }

      // Update with plain password
      await _database.child('users').child(userId).update({
        'password': newPassword,
        'updatedAt': ServerValue.timestamp,
      });

      return {
        'success': true,
        'message': 'Password updated successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to update password: ${e.toString()}'
      };
    }
  }

  // Delete user account
  Future<Map<String, dynamic>> deleteAccount(String userId, String password) async {
    try {
      // Get user data
      final snapshot = await _database.child('users').child(userId).get();
      
      if (!snapshot.exists) {
        return {
          'success': false,
          'message': 'User not found'
        };
      }

      Map<dynamic, dynamic> userData = snapshot.value as Map;
      
      // Verify password
      if (userData['password'] != password) {
        return {
          'success': false,
          'message': 'Incorrect password'
        };
      }

      // Delete user data
      await _database.child('users').child(userId).remove();
      
      // Clear shared preferences
      await logout();

      return {
        'success': true,
        'message': 'Account deleted successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to delete account: ${e.toString()}'
      };
    }
  }

  // Update user email
  Future<Map<String, dynamic>> updateEmail(String userId, String newEmail, String password) async {
    try {
      // Check if email already exists
      final emailCheck = await _database.child('users').orderByChild('email').equalTo(newEmail).get();
      
      if (emailCheck.exists) {
        return {
          'success': false,
          'message': 'Email already in use'
        };
      }

      // Get user data
      final snapshot = await _database.child('users').child(userId).get();
      
      if (!snapshot.exists) {
        return {
          'success': false,
          'message': 'User not found'
        };
      }

      Map<dynamic, dynamic> userData = snapshot.value as Map;
      
      // Verify password
      if (userData['password'] != password) {
        return {
          'success': false,
          'message': 'Incorrect password'
        };
      }

      // Update email
      await _database.child('users').child(userId).update({
        'email': newEmail,
        'updatedAt': ServerValue.timestamp,
      });

      // Update SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', newEmail);

      return {
        'success': true,
        'message': 'Email updated successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to update email: ${e.toString()}'
      };
    }
  }

  // Get user statistics
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final bookingsSnapshot = await _database
          .child('users')
          .child(userId)
          .child('bookings')
          .get();

      int totalBookings = 0;
      int pendingBookings = 0;
      int completedBookings = 0;
      int cancelledBookings = 0;

      if (bookingsSnapshot.exists) {
        Map<dynamic, dynamic> bookings = bookingsSnapshot.value as Map;
        totalBookings = bookings.length;

        bookings.forEach((key, value) {
          switch (value['status']) {
            case 'Pending':
              pendingBookings++;
              break;
            case 'Completed':
              completedBookings++;
              break;
            case 'Cancelled':
              cancelledBookings++;
              break;
          }
        });
      }

      return {
        'success': true,
        'stats': {
          'totalBookings': totalBookings,
          'pendingBookings': pendingBookings,
          'completedBookings': completedBookings,
          'cancelledBookings': cancelledBookings,
        },
        'message': 'Statistics fetched successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to fetch statistics: ${e.toString()}'
      };
    }
  }

  // Get categorized bookings
  Future<Map<String, dynamic>> getCategorizedBookings(String userId) async {
    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('bookings')
          .get();

      List<Map<String, dynamic>> upcomingBookings = [];
      List<Map<String, dynamic>> pastBookings = [];
      List<Map<String, dynamic>> cancelledBookings = [];

      if (snapshot.exists) {
        Map<dynamic, dynamic> bookingsData = snapshot.value as Map;
        
        final now = DateTime.now();

        bookingsData.forEach((key, value) {
          if (value == null) return; // Skip if value is null
          
          final booking = Map<String, dynamic>.from(value);
          // Ensure all required fields exist with default values
          booking['serviceName'] ??= 'No Service Name';
          booking['name'] ??= 'No Name';
          booking['eventDate'] ??= 'No Date';
          booking['status'] ??= 'Unknown';
          booking['guests'] ??= 0;
          
          // Parse the event date (assuming format: "dd/MM/yyyy")
          try {
            final parts = booking['eventDate'].split('/');
            final eventDate = DateTime(
              int.parse(parts[2]), // year
              int.parse(parts[1]), // month
              int.parse(parts[0]), // day
            );

            // Add booking to appropriate list based on status and date
            if (booking['status'] == 'Cancelled') {
              cancelledBookings.add(booking);
            } else if (eventDate.isBefore(now)) {
              pastBookings.add(booking);
            } else {
              upcomingBookings.add(booking);
            }
          } catch (e) {
            // If date parsing fails, add to upcoming by default
            upcomingBookings.add(booking);
          }
        });

        // Sort bookings by date
        upcomingBookings.sort((a, b) => _compareBookingDates(a, b));
        pastBookings.sort((a, b) => _compareBookingDates(b, a));
        cancelledBookings.sort((a, b) => _compareBookingDates(b, a));
      }

      return {
        'success': true,
        'bookings': {
          'upcoming': upcomingBookings,
          'past': pastBookings,
          'cancelled': cancelledBookings,
        },
        'message': 'Bookings fetched successfully'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to fetch bookings: ${e.toString()}'
      };
    }
  }

  // Helper method to compare booking dates
  int _compareBookingDates(Map<String, dynamic> a, Map<String, dynamic> b) {
    final partsA = a['eventDate'].split('/');
    final partsB = b['eventDate'].split('/');
    
    final dateA = DateTime(
      int.parse(partsA[2]),
      int.parse(partsA[1]),
      int.parse(partsA[0]),
    );
    
    final dateB = DateTime(
      int.parse(partsB[2]),
      int.parse(partsB[1]),
      int.parse(partsB[0]),
    );
    
    return dateA.compareTo(dateB);
  }

  // Add this method to FirebaseService
  Future<String> getUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('userName') ?? 'Guest';
    } catch (e) {
      print('Error getting user name: $e');
      return 'Guest';
    }
  }
} 