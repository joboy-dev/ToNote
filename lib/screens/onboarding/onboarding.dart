import 'package:flutter/material.dart';
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
    // return FutureProvider.value(
    //   value: Prefs().isDarkMode(context),
    //   initialData: false,
    //   catchError: (context, error) {
    //     log('(Wrapper) FutureProvider dark mode Error -- $error');
    //   },
    //   child: 
    return Scaffold(
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
    );
    // );
  }
}
