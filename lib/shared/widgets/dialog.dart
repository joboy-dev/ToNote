// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

showDialogBox({required BuildContext context, required Widget screen, bool dismisible=true}) {
  showDialog(
    context: context,
    barrierDismissible: dismisible,
    builder: (context) {
      return AnimatedContainer(
        duration: kAnimationDuration2,
        curve: Curves.easeInOut,
        child: AlertDialog(
          backgroundColor: kBgColor,
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          scrollable: true,
          content: screen,
        ),
      );
    },
  );
}
