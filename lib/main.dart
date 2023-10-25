import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
import 'package:todoey/shared/constants.dart';

import 'provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DevicePrefsProvider()),
      ],
      child: const ToDoEy(),
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
    Animate.restartOnHotReload = true;

    return Consumer<DevicePrefsProvider>(
      builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDo-Ey',
          themeMode: context.read<DevicePrefsProvider>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 250),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xff1E1E1E),
          ),
          initialRoute: Onboarding.id,
          routes: {
            Wrapper.id: (context) => const Wrapper(),
            Onboarding.id: (context) => const Onboarding(),
            GetStarted.id: (context) => const GetStarted(),
            SignUp.id: (context) => const SignUp(),
            Login.id: (context) => const Login(),
            LoadingDataScreen.id: (context) => const LoadingDataScreen(),
            BottomNavBar.id: (context) => const BottomNavBar(),
          },
          themeAnimationDuration: kAnimationDurationMs(100),
          themeAnimationCurve: Curves.linear,
        );
      }
    );
  }
}
