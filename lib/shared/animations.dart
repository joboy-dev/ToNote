import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:todoey/shared/constants.dart';

class MyEffects {
  static List<Effect> fadeSlide({Offset offset= const Offset(0, -0.05)}) => [
    FadeEffect(duration: kAnimationDurationMs(1200)),
    SlideEffect(duration: kAnimationDurationMs(700), begin: offset)
  ];

  static List<Effect> fade() => [
    FadeEffect(duration: kAnimationDurationMs(800))
  ];
}
