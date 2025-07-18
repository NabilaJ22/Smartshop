import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isLoggedIn => _prefs.getBool('isLoggedIn') ?? false;

  static Future<void> setLogin(bool value) async {
    await _prefs.setBool('isLoggedIn', value);
  }

  static bool get isDarkMode => _prefs.getBool('isDarkMode') ?? false;

  static Future<void> setDarkMode(bool value) async {
    await _prefs.setBool('isDarkMode', value);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }
}
