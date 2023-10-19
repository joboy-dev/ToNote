// ignore_for_file: unused_field, use_build_context_synchronously

import 'dart:math';
import 'dart:developer' as dev;

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
  const TodoItem({
    super.key,
    // required this.title,
    // required this.isChecked,
    // required this.date,
    // required this.todoId,
    // required this.todoObject,
    required this.indexId,
  });

  /* 
  todoId and indexId are very important!!!!

  todoId will be used to update a todo on the backend
  indexId will be used to retrieve data directly from the list of todos in
  provider 
  */

  final int indexId;
  // int todoId;
  // final String title;
  // bool? isChecked = false;
  // final DateTime date;
  // final Todo todoObject;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> with TickerProviderStateMixin {
  late Color color;

  late AnimationController _controller;
  late Animation<double> _animation;

  List colors = [
    kGreenColor,
    kYellowColor,
    kDarkYellowColor,
    kOrangeColor,
    const Color.fromARGB(255, 142, 184, 255),
    const Color.fromARGB(255, 218, 224, 129),
    const Color.fromARGB(255, 255, 184, 184),
  ];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: kAnimationDuration5,
    );
    _controller.forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    color = colors[Random().nextInt(colors.length).toInt()];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoView = TodoView();
    final isarService = IsarService();
    final todos = Provider.of<TodoProvider?>(context)?.todos;

    bool isLoading = false;
    String message = '';

    // get a single todo based on index id from list in provider
    Todo todo = todos![widget.indexId];

    // function to delete a todo
    deleteTodo() async {
      setState(() {
        isLoading = true;
        message = 'Deleting todo ${todo.title}...';
      });
      showSnackbar(context, message);

      var data = await todoView.deleteTodo(
        id: todo.id!,
      );

      if (data is Map) {
        await isarService.deleteTodo(todo.id!);
        await isarService.getUserTodos(context);

        setState(() {
          isLoading = false;
          message = 'Todo deleted.';
        });
      } else {
        setState(() {
          isLoading = false;
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
        isCompleted: true,
        expire: '${todo.expire}',
      );

      setState(() {
        isLoading = true;
      });

      var data = await todoView.updateTodo(
        id: todo.id!,
        todo: todoModel,
      );

      if (data is Todo) {
        // get index of the todo data
        // final index = todos.indexOf(todo);

        // save todo to isar db
        await isarService.saveTodo(data, context);

        // store completed todo in provider based on todo id passed into the
        // update todo function above
        await isarService.addCompletedTodo(widget.indexId, context);
        // await _isarService.addCompletedTodo(todo.id!, context);

        // get user todos
        await isarService.getUserTodos(context);

        setState(() {
          isLoading = false;
          message = 'Todo marked as complete';
        });
        showSnackbar(context, message);
      } else {
        setState(() {
          isLoading = false;
          message = 'Something went wrong. Try again.';
        });
      }
    }

    return Card(
      elevation: 0.0,
      color: kBgColor,
      shadowColor: Colors.transparent,
      child: Column(
        children: [
          isLoading ? const Loader(size: 25.0, color: kGreenColor) : const SizedBox(),
          ListTile(
            title: Text(
              '${todo.title}',
              // '${todo.title}',
              style: kNormalTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: todo.isCompleted!
                    ? const Color.fromARGB(255, 145, 145, 145)
                    : Colors.black,
              ),
            ),
            tileColor:
                todo.isCompleted! ? const Color.fromARGB(255, 218, 218, 218) : color,
            leading: isLoading
                ? const Loader(
                    size: 20.0,
                    color: Colors.white,
                  )
                : Checkbox(
                    checkColor: Colors.white,
                    activeColor: const Color.fromARGB(255, 145, 145, 145),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    value: todo.isCompleted,
                    // onChanged: widget.isChecked! ? (value) {} : widget.onChanged,
                    onChanged: todo.isCompleted!
                        ? (value) {
                            showSnackbar(context,
                                // 'Go to completed todos to un-check this todo');
                                'You cannot un-check a completed todo.');
                          }
                        : (value) async {
                            await toggleCompletedStatus();
                            setState(() {
                              // widget.isChecked = value;
                              todo.isCompleted = value;
                            });
                          },
                  ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    todo.isCompleted!
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
                  icon: const Icon(Icons.edit),
                  color: todo.isCompleted!
                      ? kGreyTextColor.withOpacity(0.3)
                      : const Color.fromARGB(136, 0, 0, 0),
                ),
                IconButton(
                    onPressed: () {
                      deleteTodo();
                    },
                    icon: const Icon(Icons.delete),
                    color: const Color.fromARGB(136, 0, 0, 0)),
              ],
            ),
            subtitle: Text(
              todo.isCompleted!
                  ? 'Completed'
                  : 'Expires ${todo.expire.toString().substring(0, 10)}',
              style: kNormalTextStyle.copyWith(
                  fontSize: 12.0, color: Colors.black.withOpacity(0.6)),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding: const EdgeInsets.all(0.0),
            // onTap: onTap,
          ),
          const SizedBox(height: 3.0),
        ],
      ),
    );
  }
}
