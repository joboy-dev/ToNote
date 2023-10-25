import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Icon(icon, color: mainColor, size: 30.r),
            SizedBox(width: 10.w),
            Text(
              headerText,
              style: kOtherAppBarTextStyle().copyWith(color: mainColor),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Divider(color: mainColor),
        SizedBox(height: 10.h),
      ],
    );
  }
}
