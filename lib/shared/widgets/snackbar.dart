import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
          Text(text, style: kNormalTextStyle.copyWith(color: Colors.white)),
      backgroundColor: kDarkYellowColor,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
    ),
  );
}

clearSnackBars(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}
