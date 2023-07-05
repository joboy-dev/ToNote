// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'dart:developer' as dev;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/screens/main/dialog_screens/edit_todo.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/custom_appbar.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';
import 'package:todoey/shared/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  static const String id = 'todo';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> with TickerProviderStateMixin {
  Random random = Random();
  bool? isChecked = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  // late AnimationController _controller1;
  // late Animation<double> _animation1;

  // late AnimationController _controller2;
  // late Animation<double> _animation2;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: kAnimationDuration3,
    );

    // _controller1 = AnimationController(
    //   vsync: this,
    //   duration: kAnimationDuration1,
    // );

    // _controller2 = AnimationController(
    //   vsync: this,
    //   duration: kAnimationDuration1,
    // );

    // handle all animations one by one
    _controller.forward();
    // .whenCompleteOrCancel(() {
    //   _controller1.forward().whenCompleteOrCancel(() {
    //     _controller2.forward();
    //   });
    // });

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //   parent: _controller1,
    //   curve: Curves.linearToEaseOut,
    // ));

    // _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //   parent: _controller2,
    //   curve: Curves.linear,
    // ));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _controller1.dispose();
    // _controller2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    final todos = Provider.of<TodoProvider?>(context)?.todos;

    return user == null
        ? ErrorLoadingScreen()
        : Scaffold(
            backgroundColor: kBgColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      textColor: kGreyTextColor,
                      appBarColor: kBgColor,
                      dividerColor: kGreenColor,
                      appBarText: ' My Todos',
                      trailing: IconTextButton(
                        text: 'New',
                        fontWeight: FontWeight.bold,
                        icon: FontAwesomeIcons.plus,
                        iconColor: kGreenColor,
                        textColor: kGreenColor,
                        fontSize: 17.0,
                        gap: 20.0,
                        onPressed: () {
                          showDialogBox(
                            context: context,
                            dismisible: false,
                            screen: AddTodoScreen(),
                          );
                        },
                      ),
                    ),

                    // Todos
                    todos == null || todos.isEmpty
                        ? Center(
                            child: Text(
                              'There are no todos available.',
                              style: kGreyNormalTextStyle,
                            ),
                          )
                        : Padding(
                            padding: kAppPadding,
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: 600.0,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: todos.length,
                                  itemBuilder: (context, index) {
                                    // reverse index logic
                                    final reversedIndex =
                                        todos.length - 1 - index;
                                    // get individual todos
                                    final todo = todos[reversedIndex];
                                    dev.log(
                                        'List view backend todo id -- ${todo.id}');
                                    isChecked = todo.isCompleted;
                                    return TodoItem(
                                      tileColor: kGreenColor,
                                      // todo id for backend todo id (update in backend)
                                      todoId: todo.id!,
                                      // index id for list position (getting from provider)
                                      indexId: reversedIndex,
                                      title: '${todo.title}',
                                      isChecked: todo.isCompleted,
                                      date: DateTime.parse('${todo.expire}'),
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
          );
  }
}
