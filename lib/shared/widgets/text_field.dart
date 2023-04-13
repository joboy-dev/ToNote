// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/shared/constants.dart';

class NameTextField extends StatelessWidget {
  NameTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.onChanged,
  });

  String? initialValue;
  String hintText;
  Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: kTextFieldStyle,
      cursorColor: kYellowColor,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.person,
            color: kYellowColor,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field cannot be empty';
        } else {
          return null;
        }
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  EmailTextField({
    this.initialValue,
    this.readOnly,
    required this.onChanged,
  });

  final String? initialValue;
  bool? readOnly;

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      cursorColor: kYellowColor,
      style: kTextFieldStyle,
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Email',
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.email_rounded,
            color: kYellowColor,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        return RegExp(
                    r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!)
            ? null
            : 'Please enter a valid email';
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  PasswordTextField({
    required this.hintText,
    required this.obscureText,
    required this.onChanged,
    required this.onTap,
  });

  String hintText;
  bool obscureText;
  Function(String value) onChanged;
  Function() onTap; // for gesture detector

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kYellowColor,
      style: kTextFieldStyle,
      obscureText: obscureText,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.lock,
            color: kYellowColor,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            onTap: onTap,
            child: obscureText
                ? Icon(
                    FontAwesomeIcons.solidEye,
                    color: kYellowColor,
                    size: 20.0,
                  )
                : Icon(
                    FontAwesomeIcons.solidEyeSlash,
                    color: kYellowColor,
                    size: 20.0,
                  ),
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.length < 6) {
          return 'Password must be greater than 6 characters';
        } else {
          return null;
        }
      },
    );
  }
}
