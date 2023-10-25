import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey/shared/constants.dart';

showSnackbar(BuildContext context, String text) {
  clearSnackBars(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
          Text(text, style: kNormalTextStyle().copyWith(color: Colors.white)),
      backgroundColor: kDarkYellowColor,
      padding: EdgeInsets.symmetric(vertical: 30.r, horizontal: 10.r),
      margin: EdgeInsets.all(10.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
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
