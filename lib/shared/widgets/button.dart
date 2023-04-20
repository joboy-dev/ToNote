// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:todoey/shared/constants.dart';

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
      height: 40.0,
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
