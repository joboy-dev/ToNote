// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({super.key});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  DateTime selectedDate = DateTime.now();
  bool inactiveButton = true;

  validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      navigatorPop(context);
      showSnackbar(context, 'Todo edit successful');
    } else {}
  }

  updateButtonState() {
    setState(() {
      inactiveButton = title.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, color: kGreenColor, size: 30.0),
              SizedBox(width: 10.0),
              Text(
                'Edit Todo',
                style: kOtherAppBarTextStyle.copyWith(color: kGreenColor),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Divider(),
          SizedBox(height: 10.0),

          // Normal Text Field
          NormalTextField(
            hintText: 'Enter your todo',
            onChanged: (value) {
              setState(() {
                title = value;
                updateButtonState();
              });
            },
            cursorColor: kGreenColor,
            enabledBorderColor: kGreenColor,
            focusedBorderColor: kGreenColor,
            errorBorderColor: kRedColor,
            focusedErrorBorderColor: kRedColor,
            errorTextStyleColor: kRedColor,
            iconColor: kGreenColor,
            prefixIcon: Icons.person,
          ),
          SizedBox(height: 20.0),

          // Date field
          DateTimeField(
            hintText: '',
            enabledBorderColor: kGreenColor,
            focusedBorderColor: kGreenColor,
            errorBorderColor: kRedColor,
            focusedErrorBorderColor: kRedColor,
            errorTextStyleColor: kRedColor,
            iconColor: kGreenColor,
            onSaved: (date) {
              setState(() {
                selectedDate = date!;
              });
            },
          ),

          SizedBox(height: 20.0),
          Row(
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
                  buttonText: 'Edit Todo',
                  onPressed: () {
                    inactiveButton ? null : validateForm();
                  },
                  buttonColor: kGreenColor,
                  inactive: inactiveButton,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
