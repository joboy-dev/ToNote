import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/services/user_preferences.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/wrapper.dart';

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
    // Waiting for data to be gotten.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var prefs = await Prefs().isDarkMode(context);
      setState(() {
        kBgColor =prefs ? const Color(0xff1E1E1E) : const Color.fromARGB(255, 250, 250, 250);
        // kTextColor = prefs ? const Color.fromARGB(255, 250, 250, 250) : const Color.fromARGB(255, 126, 126, 126);
      });
    });
    // initialize animation controller
    controller = AnimationController(
      vsync: this,
      duration: kAnimationDuration3,
    );

    // create animation
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller.forward();

    // check if animation is completed then navigate to the next screen
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigatorPushReplacementNamed(context, Wrapper.id);
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
    return FutureProvider.value(
      value: Prefs().isDarkMode(context),
      initialData: false,
      catchError: (context, error) {
        log('(Wrapper) FutureProvider dark mode Error -- $error');
      },
      child: Scaffold(
        backgroundColor: kBgColor,
        body: Center(
          child: ScaleTransition(
            scale: animation,
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
              width: 250.0,
              height: 250.0,
            ),
          ),
        ),
      ),
    );
  }
}
