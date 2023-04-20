// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todoey/screens/onboarding/get_started.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  static const String id = 'onboarding';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // initialize animation controller
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // create animation
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller.forward();

    // check if animation is completed then navigate to the next screen
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigatorPushReplacementNamed(context, GetStarted.id);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            width: 250.0,
            height: 250.0,
          ),
        ),
      ),
    );
  }
}
