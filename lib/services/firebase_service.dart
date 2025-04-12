import 'package:firebase_database/firebase_database.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Hash password before storing
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

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

      // Create new user
      String hashedPassword = _hashPassword(password);
      String userId = DateTime.now().millisecondsSinceEpoch.toString();

      await _database.child('users').child(userId).set({
        'fullName': fullName,
        'email': email,
        'password': password,
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
          'message': 'User not found',
          'fullName': 'fullName',
          
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

      // Save user session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId!);
      await prefs.setString('userEmail', email);
      await prefs.setString('userName', userData!['fullName'] ?? '');
      await prefs.setBool('isLoggedIn', true);

      return {
        'success': true,
        'userId': userId,
        'userData': userData,
        'message': 'Login successful'
      };
    } catch (e) {
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
      String? userId = users.keys.first;
      String hashedPassword = _hashPassword(newPassword);

      // await _database.child('users').child(userId).update({
      //   'password': hashedPassword,
      // });

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
} 