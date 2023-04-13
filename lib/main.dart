// ignore_for_file: prefer_const_constructors

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/screens/onboarding/onboarding.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo-Ey',
      theme: ThemeData(
        scaffoldBackgroundColor: kBgColor,
        timePickerTheme: TimePickerThemeData(),
      ),
      initialRoute: GetStarted.id,
      routes: {
        Onboarding.id: (context) => Onboarding(),
        GetStarted.id: (context) => GetStarted(),
        SignUp.id: (context) => SignUp(),
        Login.id: (context) => Login(),
        BottomNavBar.id: (context) => BottomNavBar()
      },
    );
  }
}
