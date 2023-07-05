// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/notes_provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/add_notes_screen.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/services/timer.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/custom_appbar.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';
import 'package:todoey/shared/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  math.Random random = math.Random();
  bool? isChecked = false;

  LoadingTimer _loadingTimer = LoadingTimer();

  @override
  void initState() {
    super.initState();
    _loadingTimer.startTimer();
  }

  @override
  void dispose() {
    _loadingTimer.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    final todos = Provider.of<TodoProvider?>(context)?.todos;
    final notes = Provider.of<NoteProvider?>(context)?.notes;

    return user == null
        ? ErrorLoadingScreen()
        : Scaffold(
            backgroundColor: kBgColor,
            body: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ------------------TODOS-----------------------
                      CustomAppBar(
                        textColor: kGreyTextColor,
                        appBarColor: kBgColor,
                        dividerColor: kOrangeColor,
                        appBarText: ' My Latest Todos',
                        trailing: IconTextButton(
                          text: 'New',
                          fontWeight: FontWeight.bold,
                          icon: FontAwesomeIcons.plus,
                          iconColor: kOrangeColor,
                          textColor: kOrangeColor,
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
                              // child: SingleChildScrollView(
                              // child: SizedBox(
                              // height: 520.0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: todos.length,
                                itemBuilder: (context, index) {
                                  // reverse index logic
                                  final reversedIndex =
                                      todos.length - 1 - index;
                                  final todo = todos[reversedIndex];
                                  isChecked = todo.isCompleted;
                                  return TodoItem(
                                    tileColor: kOrangeColor.withOpacity(0.6),
                                    todoId: todo.id!,
                                    indexId: index,
                                    title: '${todo.title}',
                                    isChecked: todo.isCompleted,
                                    date: DateTime.parse('${todo.expire}'),
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                    // onTap: () {},
                                  );
                                },
                              ),
                              // ),
                              // ),
                            ),

                      // SizedBox(height: 20.0),

                      // ------------------NOTES-----------------------
                      CustomAppBar(
                        textColor: kGreyTextColor,
                        appBarColor: kBgColor,
                        dividerColor: kOrangeColor,
                        appBarText: ' My Latest Notes',
                        trailing: IconTextButton(
                          text: 'New',
                          fontWeight: FontWeight.bold,
                          icon: FontAwesomeIcons.plus,
                          iconColor: kOrangeColor,
                          textColor: kOrangeColor,
                          fontSize: 17.0,
                          gap: 20.0,
                          onPressed: () {
                            navigatorPushNamed(context, AddNotesScreen.id);
                          },
                        ),
                      ),

                      // Notes
                      todos == null || todos.isEmpty
                          ? Center(
                              child: Text(
                                'There are no notes available.',
                                style: kGreyNormalTextStyle,
                              ),
                            )
                          : Padding(
                              padding: kAppPadding,
                              // child: SingleChildScrollView(
                              //   child: SizedBox(
                              //     height: 600.0,
                              child: Container(
                                height: 300,
                                child: ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: todos.length,
                                  itemBuilder: (context, index) {
                                    // reverse index logic
                                    final reversedIndex =
                                        todos.length - 1 - index;
                                    final todo = todos[reversedIndex];
                                    isChecked = todo.isCompleted;
                                    return TodoItem(
                                      tileColor: kOrangeColor.withOpacity(0.6),
                                      todoId: todo.id!,
                                      indexId: index,
                                      title: '${todo.title}',
                                      isChecked: todo.isCompleted,
                                      date: DateTime.parse('${todo.expire}'),
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                      // onTap: () {},
                                    );
                                  },
                                ),
                              ),
                            ),
                      // ),
                      // ),
                      // : Padding(
                      //     padding: kAppPadding,
                      //     child: SingleChildScrollView(
                      //       child: SizedBox(
                      //         height: 210.0,
                      //         child: ListView(
                      //           children: [
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //             Text('Todos'),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      SizedBox(height: 70.0),
                    ],
                  ),
                ),
              ),
            ),
          );
    //   },
    // );
  }
}
