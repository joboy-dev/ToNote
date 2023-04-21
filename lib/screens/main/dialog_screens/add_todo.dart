// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  DateTime selectedDate = DateTime.now(); // to store date selected by user

  bool inactiveButton = true;

  validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TodoProvider().addTodo(title: title, date: selectedDate);
      // print(TodoProvider().todos);
      navigatorPop(context);
      showSnackbar(context,
          'New todo "$title" added and expires on ${selectedDate.toIso8601String().substring(0, 10)}');
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
              Icon(FontAwesomeIcons.plus, color: kGreenColor, size: 30.0),
              SizedBox(width: 10.0),
              Text(
                'Add Todo',
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
                  buttonText: 'Add Todo',
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
