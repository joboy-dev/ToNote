// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
const kGreyTextColor = Color.fromARGB(255, 126, 126, 126);
// const kTextColor = Colors.white;
const kButtonTextColor = Colors.white;
Color kBgColor = Color.fromARGB(255, 250, 250, 250);
const kRedColor = Color.fromARGB(255, 206, 15, 15);
const kInactiveColor = Color.fromARGB(255, 199, 199, 199);
kScaffoldBgColor(BuildContext context) =>Theme.of(context).scaffoldBackgroundColor;

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
var kAppBarTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: kTextColor,
  fontFamily: fontFamily,
);

const kOtherAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kWhiteTextColor,
  fontFamily: fontFamily,
);

var kNormalTextStyle = TextStyle(
  fontSize: 17.0,
  color: kTextColor,
  fontFamily: fontFamily,
);

const kGreyNormalTextStyle = TextStyle(
  fontSize: 17.0,
  color: kGreyTextColor,
  fontFamily: fontFamily,
);

var kTextFieldStyle = TextStyle(
  fontSize: 14.0,
  color: kTextColor,
  fontFamily: fontFamily,
);

// APPLICATION GENERAL PADDING
const kAppPadding = EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0);

// TEXT FIELD DECORATION
var kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: kTextFieldStyle.copyWith(color: Colors.black.withOpacity(0.5)),
  prefixIcon: const Icon(Icons.person),
  labelStyle: const TextStyle(
    color: kYellowColor,
    fontWeight: FontWeight.w300,
    fontSize: 10.0,
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: kDarkYellowColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: kDarkYellowColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  errorStyle: const TextStyle(
    color: kRedColor,
  ),
);
