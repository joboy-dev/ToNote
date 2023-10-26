// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/device_prefs_provider.dart';

bool kDarkMode = false;

// COLORS
const kYellowColor = Color(0xFFFFC901);
const kDarkYellowColor = Color(0xFF958446);
const kGreenColor = Color(0xFF51D89D);
const kOrangeColor = Color(0xFFFFA500);
Color kTextColor = Color.fromARGB(255, 126, 126, 126);
const kWhiteTextColor = Colors.white;
const kGreyTextColor = Color.fromARGB(255, 78, 78, 78);
// const kTextColor = Colors.white;
const kButtonTextColor = Colors.white;
Color kLightColor = Color.fromARGB(255, 250, 250, 250);
const kRedColor = Color.fromARGB(255, 206, 15, 15);
const kInactiveColor = Color.fromARGB(255, 199, 199, 199);
Color kScaffoldBgColor(BuildContext context) =>Theme.of(context).scaffoldBackgroundColor;

// THEME BASED FONT COLOR
Color kFontTheme(BuildContext context) {
  final darkMode = context.watch<DevicePrefsProvider>().isDarkMode;
  return darkMode ? Color.fromARGB(255, 184, 184, 184).withOpacity(0.8) : Color.fromARGB(255, 116, 116, 116);
}

// RESPONSIVENESS
kHeightWidth(BuildContext context) {
  return MediaQuery.of(context).size;
}

// ANIMATION DURATION
kAnimationDurationMs(int ms) => Duration(milliseconds: ms);
const kAnimationDuration1 = Duration(seconds: 1);
const kAnimationDuration2 = Duration(seconds: 2);
const kAnimationDuration3 = Duration(seconds: 3);
const kAnimationDuration4 = Duration(seconds: 4);
const kAnimationDuration5 = Duration(seconds: 5);

// FONT FAMILY
const fontFamily = 'Poppins';

// TEXT STYLE
TextStyle kAppBarTextStyle() => TextStyle(
  fontSize: 22.sp,
  fontWeight: FontWeight.bold,
  color: kTextColor,
  fontFamily: fontFamily,
);

TextStyle kOtherAppBarTextStyle() => TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
  color: kWhiteTextColor,
  fontFamily: fontFamily,
);

TextStyle kNormalTextStyle() => TextStyle(
  fontSize: 17.sp,
  color: kTextColor,
  fontFamily: fontFamily,
);

TextStyle kGreyNormalTextStyle(BuildContext context) => TextStyle(
  fontSize: 17.sp,
  color: kTextTheme(context).withOpacity(0.7),
  fontFamily: fontFamily,
);

TextStyle kTextFieldStyle(BuildContext context) => kGreyNormalTextStyle(context).copyWith(
  fontSize: 14.sp,
);

Color kTextTheme(BuildContext context) {
  final darkMode = context.watch<DevicePrefsProvider>().isDarkMode;
  return darkMode ? kLightColor : kGreyTextColor;
}

// APPLICATION GENERAL PADDING
EdgeInsets kAppPadding() => EdgeInsets.only(left: 15.r, right: 15.r, top: 15.r);

// TEXT FIELD DECORATION
InputDecoration kTextFieldDecoration(BuildContext context) => InputDecoration(
  hintText: '',
  hintStyle: kTextFieldStyle(context).copyWith(color: Colors.black.withOpacity(0.5)),
  prefixIcon: const Icon(Icons.person),
  labelStyle: TextStyle(
    color: kYellowColor,
    fontWeight: FontWeight.w300,
    fontSize: 10.sp,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkYellowColor, width: 1.w),
    borderRadius: BorderRadius.all(Radius.circular(5.r)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkYellowColor, width: 1.w),
    borderRadius: BorderRadius.all(Radius.circular(5.r)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 1.w),
    borderRadius: BorderRadius.all(Radius.circular(5.r)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 1.w),
    borderRadius: BorderRadius.all(Radius.circular(5.r)),
  ),
  errorStyle: TextStyle(
    color: kRedColor,
    fontSize: 14.sp
  ),
);
