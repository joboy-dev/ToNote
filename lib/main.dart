// ignore_for_file: prefer_const_constructors

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/auth_provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/screens/main/add_profile_picture_screen.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/screens/onboarding/onboarding.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/wrapper.dart';

import 'provider/user_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: ToDoEy(),
    ),
  );
}

class ToDoEy extends StatelessWidget {
  const ToDoEy({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo-Ey',
      theme: ThemeData(
        scaffoldBackgroundColor: kBgColor,
        timePickerTheme: TimePickerThemeData(),
      ),
      initialRoute: Onboarding.id,
      routes: {
        Wrapper.id: (context) => Wrapper(),
        Onboarding.id: (context) => Onboarding(),
        GetStarted.id: (context) => GetStarted(),
        SignUp.id: (context) => SignUp(),
        Login.id: (context) => Login(),
        AddProfilePicture.id: (context) => AddProfilePicture(),
        BottomNavBar.id: (context) => BottomNavBar()
      },
    );
  }
}
