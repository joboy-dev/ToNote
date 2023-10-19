import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoey/shared/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, required this.size, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color ?? kDarkYellowColor,
      size: size,
    );
  }
}
