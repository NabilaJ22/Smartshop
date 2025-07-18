import 'package:flutter/material.dart';
import '../utils/shared_prefs.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = SharedPrefs.isDarkMode;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    SharedPrefs.setDarkMode(_isDark);
    notifyListeners();
  }
}
