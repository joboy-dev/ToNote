// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/todo/todo_view.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/screens/main/dialog_screens/edit_todo.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

import 'dialog.dart';

class TodoItem extends StatefulWidget {
  TodoItem({
    super.key,
    required this.title,
    required this.isChecked,
    required this.date,
    required this.onChanged,
    required this.todoId,
    required this.indexId,
    required this.tileColor,
  });

  /* 
  todoId and indexId are very important!!!!

  todoId will be used to update a todo on the backend
  indexId will be used to retrieve data directly from the list of todos in
  provider 
  */

  int todoId;
  int indexId;
  final String title;
  bool? isChecked = false;
  final DateTime date;
  Function(bool? value) onChanged;
  Color tileColor;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late Color color;

  List colors = [
    kGreenColor,
    kYellowColor,
    kDarkYellowColor,
    kOrangeColor,
    Color.fromARGB(255, 142, 184, 255),
    Color.fromARGB(255, 218, 224, 129),
    Color.fromARGB(255, 255, 184, 184),
  ];

  @override
  void initState() {
    color = colors[Random().nextInt(colors.length).toInt()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _todoView = TodoView();
    final _isarService = IsarService();
    final todos = Provider.of<TodoProvider?>(context)?.todos;

    bool _isLoading = false;
    String message = '';

    Todo todo = todos![widget.indexId];

    deleteTodo() async {
      setState(() {
        _isLoading = true;
        message = 'Deleting todo ${todo.title}...';
      });
      showSnackbar(context, message);

      var data = await _todoView.deleteTodo(
        id: todo.id!,
      );

      if (data is Map) {
        await _isarService.deleteTodo(todo.id!);
        await _isarService.getUserTodos(context);

        setState(() {
          _isLoading = false;
          message = 'Todo deleted.';
        });
      } else {
        setState(() {
          _isLoading = false;
          message = 'Something went wrong. Try again.';
        });
      }
      showSnackbar(context, message);
    }

    return Column(
      children: [
        _isLoading ? Loader(size: 25.0, color: kGreenColor) : SizedBox(),
        ListTile(
          title: Text(
            '${widget.todoId}- ${widget.title}',
            style: kNormalTextStyle.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          tileColor:
              widget.isChecked! ? Color.fromARGB(255, 218, 218, 218) : color,
          leading: Checkbox(
            checkColor: kGreenColor,
            activeColor: kDarkYellowColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            value: widget.isChecked,
            onChanged: widget.isChecked! ? (value) {} : widget.onChanged,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  widget.isChecked!
                      ? showSnackbar(
                          context, 'You cannot edit a completed todo item')
                      : showDialogBox(
                          context: context,
                          screen: EditTodoScreen(
                            // backendTodoId: todoId,
                            providerTodoId: widget.indexId,
                          ),
                          dismisible: false,
                        );
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  deleteTodo();
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          subtitle: Text(
            'Expires ${widget.date.toString().substring(0, 10)}',
            style: kNormalTextStyle.copyWith(
                fontSize: 12.0, color: Colors.black.withOpacity(0.6)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding: EdgeInsets.all(0.0),
          // onTap: onTap,
        ),
        SizedBox(height: 3.0),
      ],
    );
  }
}
