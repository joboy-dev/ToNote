// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoey/shared/constants.dart';

class Loader extends StatelessWidget {
  Loader({super.key, required this.size, this.color});

  double size;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color ?? kDarkYellowColor,
      size: size,
    );
  }
}
