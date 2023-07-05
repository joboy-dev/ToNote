import 'package:flutter/material.dart';

class DevicePrefsProvider extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  void setPrefs(bool darkM) {
  // void setPrefs(DevicePrefs prefs) {
    _darkMode = darkM;
    notifyListeners();
  }
}
