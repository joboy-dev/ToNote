// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoey/shared/constants.dart';

class Loader extends StatelessWidget {
  Loader({super.key, required this.size});

  double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: kDarkYellowColor,
      size: size,
    );
  }
}
