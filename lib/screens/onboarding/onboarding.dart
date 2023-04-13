// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoey/shared/loader.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  static const String id = 'onboarding';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/logo.png'),
              width: 150.0,
              height: 150.0,
            ),
            SizedBox(height: 20.0),
            Loader(),
          ],
        ),
      ),
    );
  }
}
