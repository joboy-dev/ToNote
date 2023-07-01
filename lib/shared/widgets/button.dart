// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final bool inactive;

  Button({
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.inactive,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 50.0,
      color: inactive ? kInactiveColor : buttonColor,
      focusColor: inactive
          ? kInactiveColor.withOpacity(0.5)
          : buttonColor.withOpacity(0.5),
      elevation: inactive ? 1.0 : 2.0,
      focusElevation: inactive ? 1.0 : 4.0,
      splashColor: inactive
          ? kInactiveColor.withOpacity(0.5)
          : buttonColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: kButtonTextColor,
          fontSize: 15.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final IconData icon;

  ButtonIcon({
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 50.0,
      color: buttonColor,
      focusColor: buttonColor.withOpacity(0.5),
      elevation: 2.0,
      focusElevation: 4.0,
      splashColor: buttonColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              size: 20.0,
              color: kWhiteTextColor,
            ),
          ),
          SizedBox(width: 5.0),
          Expanded(
            flex: 2,
            child: Text(
              buttonText,
              style: TextStyle(
                color: kButtonTextColor,
                fontSize: 15.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  ButtonText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  final String firstText, secondText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: kGreyNormalTextStyle,
          children: [
            TextSpan(
              text: secondText,
              style: kNormalTextStyle.copyWith(
                color: kGreenColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleButton extends StatelessWidget {
  DoubleButton({
    super.key,
    required this.inactiveButton,
    required this.button2Text,
    required this.button2Color,
    required this.button2onPressed,
  });

  final bool inactiveButton;
  final String button2Text;
  final Color button2Color;
  Function() button2onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Button(
            buttonText: 'Cancel',
            onPressed: () {
              navigatorPop(context);
            },
            buttonColor: kRedColor,
            inactive: false,
          ),
        ),
        SizedBox(width: 5.0),
        Expanded(
          child: Button(
            buttonText: button2Text,
            onPressed: button2onPressed,
            buttonColor: button2Color,
            inactive: inactiveButton,
          ),
        ),
      ],
    );
  }
}

class IconTextButton extends StatelessWidget {
  IconTextButton({
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
    this.fontSize,
    this.textColor,
    this.gap,
    this.fontWeight,
  });

  final String text;
  final IconData icon;
  final Color iconColor;
  final Color? textColor;
  final double? fontSize;
  final double? gap;
  final FontWeight? fontWeight;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: gap ?? 20.0),
            Text(
              text,
              style: kGreyNormalTextStyle.copyWith(
                fontSize: fontSize ?? 17.0,
                color: textColor ?? kGreyTextColor,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
