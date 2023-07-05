// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/todo/todo_view.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

class DeleteTodoScreen extends StatefulWidget {
  DeleteTodoScreen({super.key, required this.providerTodoId});

  int providerTodoId;

  @override
  State<DeleteTodoScreen> createState() => _DeleteTodoScreenState();
}

class _DeleteTodoScreenState extends State<DeleteTodoScreen> {
  bool _isLoading = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    final _todoView = TodoView();
    final todos = Provider.of<TodoProvider?>(context)?.todos;

    Todo todo = todos![widget.providerTodoId];

    deleteTodo() async {
      setState(() {
        _isLoading = true;
      });

      var data = await _todoView.deleteTodo(
        id: todo.id!,
      );

      if (data is Map) {
        // await IsarService().saveTodo(data, context);
        await IsarService().deleteTodo(todo.id!);
        await IsarService().getUserTodos(context);
        navigatorPop(context);

        setState(() {
          _isLoading = false;
          message = 'Todo deleted.';
        });
        showSnackbar(context, message);
      } else {
        setState(() {
          _isLoading = false;
          message = 'Something went wrong. Try again.';
        });
      }
    }

    return Column(
      children: [
        DialogHeader(
          headerText: 'Delete Todo',
          icon: Icons.delete_rounded,
          mainColor: kRedColor,
        ),
        SizedBox(height: 10.0),
        Text("Are you sure you want to detele todo '${todo.title}'?",
            style: kGreyNormalTextStyle),
        SizedBox(height: 20.0),
        DoubleButton(
          inactiveButton: false,
          button2Text: 'Delete',
          button2Color: kGreenColor,
          button2onPressed: () async {
            deleteTodo();
          },
        ),
        SizedBox(height: 10.0),
        _isLoading
            ? Loader(
                size: 20.0,
                color: kGreenColor,
              )
            : SizedBox(),
        message.isEmpty
            ? SizedBox(height: 0.0)
            : Center(
                child: Text(
                  message,
                  style: kNormalTextStyle.copyWith(color: kRedColor),
                ),
              ),
      ],
    );
  }
}
