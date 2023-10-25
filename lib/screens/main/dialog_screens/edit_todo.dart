// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/todo/todo_view.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({
    super.key,
    required this.providerTodoId,
  });

  // int backendTodoId;
  final int providerTodoId;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  DateTime? selectedDate;

  bool _isLoading = false;
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isarService = IsarService();
    final todoView = TodoView();

    // get all todos from provider
    final todos = Provider.of<TodoProvider?>(context)?.todos;

    // get a single todo based on the index id of a todo passed into this screen
    // from provider
    Todo todo = todos![widget.providerTodoId];

    log('EditTodo dialog provider todo id -- ${widget.providerTodoId}');
    log('EditTodo dialog index todo id -- ${todo.id}');

    validateForm() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        TodoModel todoModel = TodoModel(
          title: title ?? '${todo.title}',
          isCompleted: todo.isCompleted!,
          expire: selectedDate!.toIso8601String().substring(0, 10)
          // ??
          // '${todo.expire}',
        );

        setState(() {
          _isLoading = true;
        });

        if (selectedDate!.isBefore(DateTime.now())) {
          setState(() {
            _isLoading = false;
            message = 'Date is in the past.';
          });
        } else {
          setState(() {
            message = '';
          });
          
          var data = await todoView.updateTodo(
            id: todo.id!,
            todo: todoModel,
          );

          if (data is Todo) {
            await isarService.saveTodo(data, context);
            await isarService.getUserTodos(context);

            setState(() {
              _isLoading = false;
              message = 'Todo edit successful';
            });
            navigatorPop(context);
            showSnackbar(context, message);
          } else {
            setState(() {
              _isLoading = false;
              message = 'Something went wrong. Try again.';
            });
          }
        }
      } else {}
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const DialogHeader(
            headerText: 'Edit Todo',
            icon: FontAwesomeIcons.pencil,
            mainColor: kGreenColor,
          ),
          const SizedBox(height: 10.0),

          // Normal Text Field
          NormalTextField(
            initialValue: todo.title,
            hintText: 'Enter your todo',
            onChanged: (value) {
              setState(() {
                title = value!;
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

          // Date field
          DateTimeField(
            initialValue: todo.expire,
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

          DoubleButton(
            inactiveButton: false, 
            button2Text: 'Edit Todo', 
            button2Color: kGreenColor, 
            button2onPressed: validateForm
          ),
          SizedBox(height: 10.h),

          _isLoading
              ? Loader(size: 20.r, color: kGreenColor)
              : const SizedBox(height: 0.0),

          message.isEmpty
              ? const SizedBox(height: 0.0)
              : Center(
                  child: Text(
                    message,
                    style: kNormalTextStyle().copyWith(color: kRedColor),
                  ),
                ),
        ].animate(
          delay: kAnimationDurationMs(500),
          interval: kAnimationDurationMs(50),
          effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
        ),
      ),
    );
  }
}
