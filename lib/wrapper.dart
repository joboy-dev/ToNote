// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/device_prefs_provider.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/services/token_storage.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/services/user_preferences.dart';
import 'package:todoey/shared/bottom_navbar.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});
  static const String id = 'wrapper/';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  /* variable to store user token which will help in the appropriate screen
   to navigate to upon leaving the onboarding screen */
  String? _token;

  final TokenStorage _storage = TokenStorage();

  var data;

  @override
  void initState() {
    // get current user token
    // _storage.getToken().then((token) {
    //   // assign the generated token to the _token variable
    //   setState(() {
    //     _token = token;
    //   });
    // });
    // final prefsDarkMode = Provider.of<DevicePrefsProvider>(context).darkMode;

    // Waiting for data to be gotten.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? token = await _storage.getToken();
      setState(() {
        _token = token;
      });

      var prefs = await Prefs().isDarkMode(context);
      setState(() {
        kBgColor = prefs
            ? Color(0xff1E1E1E)
            : Color.fromARGB(255, 250, 250, 250);
      });

      // get user details before it is stored in provider
      // this is done to get the user dark mode value
      var user = await IsarService().getUserDetails(context);
      if (user is User) {
        log('(Wrapper) user -- ${user.firstName}');

        var todos = await IsarService().getUserTodos(context);
        if (todos is List<Todo>) {
          log('(Wrapper) todos length -- ${todos.length} ');
        }
      } else {
        return;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Wrapper widget read token from storage -- $_token');

    if (_token == null && data == null) {
      return GetStarted();
    } else {
      // store user details in future provider
      return FutureProvider.value(
        value: IsarService().getUserDetails(context),
        initialData: null,
        catchError: (context, error) {
          log('(Wrapper) FutureProvider user Error -- $error');
        },
        // store user todos in future provider
        child: FutureProvider.value(
          value: IsarService().getUserTodos(context),
          initialData: null,
          catchError: (context, error) {
            log('(Wrapper) FutureProvider todos Error -- $error');
          },
          child: BottomNavBar(),
        ),
      );
    }
  }
}
