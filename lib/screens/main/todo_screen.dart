
// ignore_for_file: unused_field

import 'dart:developer' as dev;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/custom_appbar.dart';
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

  // bool _isLoading = true;
  String message = '';

  late AnimationController _controller;
  late Animation<double> _animation;

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
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    final todos = Provider.of<TodoProvider?>(context)?.todos;

    // Todo? todo;

    return user == null
        ? const ErrorLoadingScreen()
        : Scaffold(
            // backgroundColor: kBgColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      textColor: kGreyTextColor,
                      // appBarColor: kBgColor,
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
                            screen: const AddTodoScreen(),
                          );
                        },
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     IconTextButton(
                    //       text: 'View all completed todos',
                    //       icon: Icons.check_box_rounded,
                    //       iconColor: kGreenColor,
                    //       gap: 5.0,
                    //       fontSize: 14.0,
                    //       onPressed: () {
                    //         navigatorPushNamed(
                    //             context, CompletedTodosScreen.id);
                    //       },
                    //     ),
                    //   ],
                    // ),

                    // Todos
                    todos == null || todos.isEmpty
                        ? const Center(
                            child: Text(
                              'There are no todos available.',
                              style: kGreyNormalTextStyle,
                            ),
                          )
                        : Padding(
                            padding: kAppPadding,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: ListView.builder(
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
                                    // index id for list position (getting from provider)
                                    indexId: reversedIndex,
                                  ).animate(
                                    delay: kAnimationDurationMs(500),
                                    effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
                                  );
                                },
                              ),
                            ),
                          ),
                    const SizedBox(height: 10.0),
                  ].animate(
                    delay: kAnimationDurationMs(200),
                    interval: kAnimationDurationMs(50),
                    effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
                  ),
                ),
              ),
            ),
          );
  }
}
