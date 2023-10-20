import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/custom_appbar.dart';
import 'package:todoey/shared/widgets/completed_todo_item.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({super.key});

  static const String id = 'completed_todos';

  // final Todo todoObject;

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {
  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoProvider?>(context)?.completedTodos;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(
              textColor: kGreyTextColor,
              appBarColor: kBgColor,
              dividerColor: kGreenColor,
              appBarText: ' My Completed Todos',
              trailing: const SizedBox(),
            ),

            // Todos
            todos == null || todos.isEmpty
                ? const Center(
                    child: Text(
                      'You have no completed todos.',
                      style: kGreyNormalTextStyle,
                    ),
                  )
                : Padding(
                    padding: kAppPadding,
                    child: SizedBox(
                      height: 520.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          // reverse index logic
                          final reversedIndex = todos.length - 1 - index;
                          // get individual todos
                          final todo = todos[index];
                          log('List view backend todo id -- ${todo.id}');
                          // isChecked = todo.isCompleted;
                          return CompletedTodoItem(
                            // todo id for backend todo id (update in backend)
                            todoId: todo.id!,
                            // index id for list position (getting from provider)
                            indexId: reversedIndex,
                            // title: '${todo.title}',
                            // isChecked: todo.isCompleted,
                            // date: DateTime.parse('${todo.expire}'),
                          );
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}
