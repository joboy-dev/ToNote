import 'package:flutter/material.dart';

slideTransitionAnimation({
  required double dx,
  required double dy,
  required Animation<double> animation,
}) {
  return Tween<Offset>(
    begin: Offset(dx, dy),
    end: Offset.zero,
  ).animate(animation);
}
