// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// COLORS
const kYellowColor = Color(0xFFFFC901);
const kDarkYellowColor = Color(0xFF958446);
const kGreenColor = Color(0xFF51D89D);
const kOrangeColor = Color(0xFFFFA500);
const kTextColor = Color(0xff1E1E1E);
const kWhiteTextColor = Colors.white;
const kGreyTextColor = Color.fromARGB(255, 126, 126, 126);
// const kTextColor = Colors.white;
const kButtonTextColor = Colors.white;
const kBgColor = Color.fromARGB(255, 250, 250, 250);
// const kBgColor = Color(0xff1E1E1E);
const kRedColor = Color.fromARGB(255, 206, 15, 15);
const kInactiveColor = Color.fromARGB(255, 199, 199, 199);

// ANIMATION DURATION
const kAnimationDuration1 = Duration(seconds: 1);
const kAnimationDuration2 = Duration(seconds: 2);
const kAnimationDuration3 = Duration(seconds: 3);
const kAnimationDuration4 = Duration(seconds: 4);
const kAnimationDuration5 = Duration(seconds: 5);

// FONT FAMILY
const fontFamily = 'Poppins';

// TEXT STYLE
const kAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kTextColor,
  fontFamily: fontFamily,
);

const kOtherAppBarTextStyle = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.bold,
  color: kWhiteTextColor,
  fontFamily: fontFamily,
);

const kNormalTextStyle = TextStyle(
  fontSize: 15.0,
  color: kTextColor,
  fontFamily: fontFamily,
);

const kGreyNormalTextStyle = TextStyle(
  fontSize: 15.0,
  color: kGreyTextColor,
  fontFamily: fontFamily,
);

const kTextFieldStyle = TextStyle(
  fontSize: 12.0,
  color: kTextColor,
  fontFamily: fontFamily,
);

// APPLICATION GENERAL PADDING
const kAppPadding = EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0);

// TEXT FIELD DECORATION
var kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: kTextFieldStyle.copyWith(color: Colors.black.withOpacity(0.5)),
  prefixIcon: Icon(Icons.person),
  labelStyle: TextStyle(
    color: kYellowColor,
    fontWeight: FontWeight.w300,
    fontSize: 10.0,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkYellowColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkYellowColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  errorStyle: TextStyle(
    color: kRedColor,
  ),
);
