import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoey/shared/constants.dart';

showDialogBox(
    {required BuildContext context,
    required Widget screen,
    bool dismisible = true}) {
  showDialog(
    context: context,
    barrierDismissible: dismisible,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.black,
        elevation: 4.r,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        scrollable: true,
        content: screen.animate().fadeIn(duration: kAnimationDurationMs(200)),
      );
    },
  );
}
