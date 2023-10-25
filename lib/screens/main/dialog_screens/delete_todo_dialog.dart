// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

class DeleteTodoScreen extends StatefulWidget {
  const DeleteTodoScreen({super.key, required this.providerTodoId});

  final int providerTodoId;

  @override
  State<DeleteTodoScreen> createState() => _DeleteTodoScreenState();
}

class _DeleteTodoScreenState extends State<DeleteTodoScreen> {
  bool _isLoading = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    final todoView = TodoView();
    final todos = Provider.of<TodoProvider?>(context)?.todos;

    Todo todo = todos![widget.providerTodoId];

    deleteTodo() async {
      setState(() {
        _isLoading = true;
      });

      var data = await todoView.deleteTodo(
        id: todo.id!,
      );

      if (data is Map) {
        // await IsarService().saveTodo(data, context);
        await IsarService().deleteTodo(todo.id!);
        setState(() {
          _isLoading = false;
          message = 'Todo deleted.';
        });
        await IsarService().getUserTodos(context);
        navigatorPop(context);

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
        const DialogHeader(
          headerText: 'Delete Todo',
          icon: Icons.delete_rounded,
          mainColor: kRedColor,
        ),
        const SizedBox(height: 10.0),
        Text("Are you sure you want to detele todo '${todo.title}'?",
            style: kGreyNormalTextStyle),
        const SizedBox(height: 20.0),
        DoubleButton(
          inactiveButton: false,
          button2Text: 'Delete',
          button2Color: kGreenColor,
          button2onPressed: () async {
            deleteTodo();
          },
        ),
        const SizedBox(height: 10.0),
        _isLoading
            ? const Loader(
                size: 20.0,
                color: kGreenColor,
              )
            : const SizedBox(),
        message.isEmpty
            ? const SizedBox(height: 0.0)
            : Center(
                child: Text(
                  message,
                  style: kNormalTextStyle.copyWith(color: kRedColor),
                ),
              ),
      ].animate(
          delay: kAnimationDurationMs(500),
          interval: kAnimationDurationMs(50),
          effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
        ),
    );
  }
}
