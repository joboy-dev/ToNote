// ignore_for_file: prefer_const_constructors

// import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/auth_provider.dart';
import 'package:todoey/provider/loading_provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/screens/authentication/login.dart';
import 'package:todoey/screens/authentication/signup.dart';
import 'package:todoey/screens/main/add_profile_picture_screen.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
import 'package:todoey/screens/main/notes_screen.dart';
import 'package:todoey/screens/main/home_screen.dart';
import 'package:todoey/screens/main/profile_screen.dart';
import 'package:todoey/screens/main/todo_screen.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/screens/onboarding/onboarding.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/services/timer.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/wrapper.dart';

import 'provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LoadingTimer()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        // FutureProvider<User?>.value(
        //   value: IsarService().getUserDetails(),
        //   initialData: null,
        //   catchError: (context, error) {
        //     log('(Main Function) FutureProvider Error -- $error');
        //   },
        // )
        // FutureProvider<User?>(
        //   create: (_) => IsarService().getUserDetails(),
        //   initialData: null,
        //   catchError: (context, error) {
        //     log('(Main Function) FutureProvider Error -- $error');
        //   },
        // )
      ],
      child: ToDoEy(),
    ),
  );
}

class ToDoEy extends StatelessWidget {
  const ToDoEy({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureProvider<User?>.value(
        // create: (_) => IsarService().getUserDetails(context),
        value:IsarService().getUserDetails(context),
        initialData: null,
        catchError: (context, error) {
          log('(Main Function) FutureProvider Error -- $error');
        },
        child: MaterialApp(
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
            LoadingDataScreen.id: (context) => LoadingDataScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            TodoScreen.id: (context) => TodoScreen(),
            NotesScreen.id: (context) => NotesScreen(),
            ProfileScreen.id: (context) => ProfileScreen(),
            AddProfilePicture.id: (context) => AddProfilePicture(),
            BottomNavBar.id: (context) => BottomNavBar(),
            // LoadingScreen.id: (context) => LoadingScreen()
          },
        ));
  }
}
