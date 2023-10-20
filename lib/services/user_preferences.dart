// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../provider/device_prefs_provider.dart';

// class Prefs {
//   static const String _kDarkModeKey = 'isDarkMode';

//   Future setDarkMode(BuildContext context, {bool value = false}) async {
//     final preferences = await SharedPreferences.getInstance();
//     preferences.setBool(_kDarkModeKey, value);

//     // set preferences in provider
//     Provider.of<DevicePrefsProvider>(context, listen: false).setPrefs(value);
//     log('Shared Preferences dark mode -- ${Provider.of<DevicePrefsProvider>(context, listen: false).darkMode}');
//   }

//   // Future isDarkMode(BuildContext context) async {
//   Future isDarkMode(BuildContext context) async {
//     final preferences = await SharedPreferences.getInstance();
//     bool? isDarkMode = preferences.getBool(_kDarkModeKey);
    
//     // check is key is holding a null value
//     if (isDarkMode != null) {
//       // set preferences in provider
//       Provider.of<DevicePrefsProvider>(context, listen: false)
//           .setPrefs(isDarkMode);
//       log('Shared Preferences dark mode -- ${Provider.of<DevicePrefsProvider>(context, listen: false).darkMode}');

//       return isDarkMode;
//     } else {
//       Provider.of<DevicePrefsProvider>(context, listen: false).setPrefs(false);
//       return false;
//     }
//   }
// }
