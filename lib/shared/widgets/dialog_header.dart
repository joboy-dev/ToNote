import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    super.key,
    required this.headerText,
    this.icon,
    required this.mainColor,
  });

  final String headerText;
  final IconData? icon;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: mainColor, size: 30.0),
            const SizedBox(width: 10.0),
            Text(
              headerText,
              style: kOtherAppBarTextStyle.copyWith(color: mainColor),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Divider(color: mainColor),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
