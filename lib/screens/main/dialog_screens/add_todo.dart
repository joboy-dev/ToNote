// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/backend/todo/todo_view.dart';
// import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _todoView = TodoView();
  // final _userView = UserView();

  String title = '';
  DateTime selectedDate = DateTime.now(); // to store date selected by user

  String message = '';
  bool _isLoading = false;

  bool inactiveButton = true;


  validateForm() async {
    
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      TodoModel todo = TodoModel(
        title: title,
        // because it is date, it has to be converted
        expire: selectedDate.toIso8601String().substring(0, 10),
        isCompleted: false,
      );

      log('Todo date -- ${todo.expire}');

      setState(() {
        _isLoading = true;
      });

      // check if date is in the past
      if (selectedDate.isBefore(DateTime.now())) {
        setState(() {
          _isLoading = false;
          message =
              'Date is in the past.';
        });
      } else {
        // perform adding todo function
        var data = await _todoView.addTodo(todo: todo);

        // if (data is Map) {
        if (data is Todo) {
          await IsarService().saveTodo(data, context);

          setState(() {
            _isLoading = false;
            message =
                'New todo "$title" added and expires on ${selectedDate.toIso8601String().substring(0, 10)}';
          });

          navigatorPop(context);
          showSnackbar(context, message);
        } else if (data == 400) {
          setState(() {
            _isLoading = false;
            message = 'Something went wrong try again';
          });
        } else {
          setState(() {
            _isLoading = false;
            message = 'Something went wrong try again';
          });
        }
      }
    }
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
          DialogHeader(
            headerText: 'Add Todo',
            icon: FontAwesomeIcons.plus,
            mainColor: kGreenColor,
          ),

          // Normal Text Field
          NormalTextField(
            hintText: 'Enter your todo',
            onChanged: (value) {
              setState(() {
                title = value!;
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
            prefixIcon: Icons.check_circle_outline,
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

          DoubleButton(
            inactiveButton: inactiveButton,
            button2Text: 'Add Todo',
            button2Color: kGreenColor,
            button2onPressed: () {
              inactiveButton ? null : validateForm();
            },
          ),

          SizedBox(height: 10.0),

          _isLoading
              ? Loader(size: 20.0, color: kGreenColor)
              : SizedBox(height: 0.0),

          message.isEmpty
              ? SizedBox(height: 0.0)
              : Center(
                  child: Text(
                    message,
                    style: kNormalTextStyle.copyWith(color: kRedColor),
                  ),
                ),
        ],
      ),
    );
  }
}
