// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/auth_provider.dart';
import 'package:todoey/provider/device_prefs_provider.dart';
import 'package:todoey/provider/notes_provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/screens/onboarding/onboarding.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/wrapper.dart';

import 'provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DevicePrefsProvider()),
        // ChangeNotifierProvider(create: (_) => LoadingTimer()),
        // ChangeNotifierProvider(create: (_) => LoadingProvider()),
      ],
      child: ToDoEy(),
    ),
  );
}

class ToDoEy extends StatefulWidget {
  const ToDoEy({super.key});

  @override
  State<ToDoEy> createState() => _ToDoEyState();
}

class _ToDoEyState extends State<ToDoEy> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo-Ey',
      // themeMode: Prefs().isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Color.fromARGB(255, 250, 250, 250),
      // ),
      // darkTheme: ThemeData(
      //   scaffoldBackgroundColor: Color(0xff1E1E1E),
      // ),
      initialRoute: Onboarding.id,
      routes: {
        Wrapper.id: (context) => Wrapper(),
        Onboarding.id: (context) => Onboarding(),
        GetStarted.id: (context) => GetStarted(),
        SignUp.id: (context) => SignUp(),
        Login.id: (context) => Login(),
        LoadingDataScreen.id: (context) => LoadingDataScreen(),
        BottomNavBar.id: (context) => BottomNavBar(),
      },
    );
  }
}
