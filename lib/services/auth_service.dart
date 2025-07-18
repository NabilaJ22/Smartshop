import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class AuthService {
  static const String _userKey = 'loggedInUser';

  /// Dummy login using predefined email and password
  static Future<bool> login(String email, String password) async {
    if (email == AppConstants.dummyEmail && password == AppConstants.dummyPassword) {
      final prefs = await SharedPreferences.getInstance();
      // Save login state and user info
      await prefs.setBool(AppConstants.keyIsLoggedIn, true);
      await prefs.setString(_userKey, json.encode({'email': email}));
      return true;
    }
    return false;
  }

  /// Dummy register - for now just returns true after a delay
  static Future<bool> register(String email, String password, String name) async {
    // Simulate API delay
    await Future.delayed(Duration(seconds: 1));
    // Here you can add logic to save user info locally or via API
    return true;
  }

  /// Logout user by clearing SharedPreferences keys
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyIsLoggedIn);
    await prefs.remove(_userKey);
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  /// Get user email (dummy)
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      final data = json.decode(userJson);
      return data['email'];
    }
    return null;
  }
}
