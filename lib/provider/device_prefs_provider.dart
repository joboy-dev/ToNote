import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevicePrefsProvider extends ChangeNotifier {
  bool? _isDarkMode = false;
  String key = 'isDarkMode';

  bool get isDarkMode => _isDarkMode!;

   Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    // check against null value
    _isDarkMode = prefs.getBool(key) ?? false;
    notifyListeners();
  }

  Future<void> toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = !_isDarkMode!;
    prefs.setBool(key, _isDarkMode!);
    notifyListeners();
  }

  // load up theme mode on initialization
  DevicePrefsProvider() {
    _loadThemeMode();
  }
}
