import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Image(
          image: AssetImage('assets/images/logo.png'),
          width: 250.0,
          height: 250.0,
        ).animate(
          onComplete: (controller) {
            navigatorPushReplacement(context, const Wrapper());
          },
        )
        .scale(duration: kAnimationDurationMs(2000))
        .rotate(),
      ),
    );
    // );
  }
}
