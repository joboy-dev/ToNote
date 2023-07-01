// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
import 'package:todoey/services/token_storage.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/shared/bottom_navbar.dart';

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

  @override
  void initState() {
    // get current user token
    _storage.getToken().then((token) {
      // assign the generated token to the _token variable
      setState(() {
        _token = token;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Wrapper widget read token from storage -- $_token');

    if (_token == null) {
      return GetStarted();
    } else {
      return LoadingDataScreen();
    }
  }
}
