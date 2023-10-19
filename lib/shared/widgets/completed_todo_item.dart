// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/todo/todo_view.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

class CompletedTodoItem extends StatefulWidget {
  const CompletedTodoItem({
    super.key,
    required this.indexId,
    required this.todoId,
  });

  /* 
  indexId will be used to retrieve data directly from the list of todos in
  provider 
  */

  final int indexId, todoId;

  @override
  State<CompletedTodoItem> createState() => _CompletedTodoItemState();
}

class _CompletedTodoItemState extends State<CompletedTodoItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _todoView = TodoView();
    final _isarService = IsarService();
    final todos = Provider.of<TodoProvider?>(context)?.todos;
    // final completedTodos = Provider.of<TodoProvider?>(context)?.completedTodos;

    bool _isLoading = false;
    String message = '';

    // get a single todo based on index id from list in provider
    Todo todo = todos![widget.indexId];

    // function to delete a todo
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

    toggleCompletedStatus() async {
      // get a single todo based on the index id of a todo passed into this screen
      // from provider
      dev.log('EditTodo dialog index todo id -- ${todo.id}');

      TodoModel todoModel = TodoModel(
        title: '${todo.title}',
        isCompleted: false,
        expire: '${todo.expire}',
      );

      setState(() {
        _isLoading = true;
      });

      var data = await _todoView.updateTodo(
        id: todo.id!,
        todo: todoModel,
      );

      if (data is Todo) {
        await _isarService.saveTodo(data, context);
        await _isarService.getUserTodos(context);

        setState(() {
          _isLoading = false;
          message = 'Todo marked as incomplete';
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
        _isLoading ? const Loader(size: 25.0, color: kGreenColor) : const SizedBox(),
        ListTile(
          title: Text(
            '${todo.id}- ${todo.title}',
            style: kNormalTextStyle.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 145, 145, 145),
            ),
          ),
          tileColor: const Color.fromARGB(255, 218, 218, 218),
          leading: _isLoading
              ? const Loader(
                  size: 20.0,
                  color: Colors.white,
                )
              : Checkbox(
                  checkColor: Colors.white,
                  activeColor: kDarkYellowColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  value: todo.isCompleted,
                  onChanged: (value) async {
                    await toggleCompletedStatus();
                    setState(() {
                      todo.isCompleted = value;
                    });
                  },
                ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    showSnackbar(
                        context, 'You cannot edit a completed todo item');
                  },
                  icon: const Icon(Icons.edit),
                  color: kGreyTextColor.withOpacity(0.3)),
              IconButton(
                onPressed: () {
                  deleteTodo();
                },
                icon: const Icon(Icons.delete),
                color: const Color.fromARGB(136, 0, 0, 0),
              ),
            ],
          ),
          subtitle: Text(
            'Completed',
            style: kNormalTextStyle.copyWith(
                fontSize: 12.0, color: Colors.black.withOpacity(0.6)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding: const EdgeInsets.all(0.0),
        ),
        const SizedBox(height: 3.0),
      ],
    );
  }
}
