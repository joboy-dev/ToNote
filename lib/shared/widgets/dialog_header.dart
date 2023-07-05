// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

class DialogHeader extends StatelessWidget {
  DialogHeader({
    super.key,
    required this.headerText,
    this.icon,
    required this.mainColor,
  });

  String headerText;
  IconData? icon;
  Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: mainColor, size: 30.0),
            SizedBox(width: 10.0),
            Text(
              headerText,
              style: kOtherAppBarTextStyle.copyWith(color: mainColor),
            )
          ],
        ),
        SizedBox(height: 10.0),
        Divider(color: mainColor),
        SizedBox(height: 10.0),
      ],
    );
  }
}
