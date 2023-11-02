// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Image(
          image: const AssetImage('assets/images/logo.png'),
          width: 250.w,
          height: 250.h,
        ).animate(
          onComplete: (controller) async {
            await Future.delayed(kAnimationDurationMs(2000));
            navigatorPushReplacement(context, const Wrapper());
          },
        )
        .scale(duration: kAnimationDurationMs(2000)).saturate(duration: kAnimationDurationMs(2000))
      ),
    );
    // );
  }
}
