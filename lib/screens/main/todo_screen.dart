// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/screens/main/dialog_screens/edit_todo.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Random random = Random();
  DateTime now = DateTime.now();
  String greeting = '';

  getGreeting() {
    if (DateTime.now().hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 17) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  bool isChecked = false;

  List images = ['1.png', '2.jpg'];

  @override
  void initState() {
    getGreeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use the provider package to consume state
    return Consumer<TodoProvider>(
      builder: (context, value, child) {
        // store all todos in a variaable
        final todos = value.todos;

        return Scaffold(
          backgroundColor: kBgColor,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: kAppPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Bar
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '$greeting, First Name',
                            style: kOtherAppBarTextStyle.copyWith(
                                color: kGreenColor),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 0,
                          child: CircleAvatar(
                            backgroundColor: kGreenColor,
                          ),
                        ),
                      ],
                    ), // End App Bar

                    Divider(thickness: 2.0),
                    SizedBox(height: 10.0),

                    // Main Body
                    Text(
                      'First Name, here are your todos',
                      style: kGreyNormalTextStyle,
                    ),

                    SizedBox(height: 20.0),

                    Row(
                      children: [
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: ButtonIcon(
                            buttonText: 'Add Todo',
                            buttonColor: kGreenColor,
                            onPressed: () {
                              showDialogBox(
                                context: context,
                                screen: AddTodoScreen(),
                              );
                            },
                            icon: FontAwesomeIcons.plus,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.0),

                    // Todos
                    SizedBox(
                      height: 500.0,
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          isChecked = todo.isCompleted;
                          return TodoItem(
                            title: todo.title,
                            isChecked: todo.isCompleted,
                            date: todo.expire,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  TodoItem({
    super.key,
    required this.title,
    required this.isChecked,
    required this.date,
    required this.onChanged,
  });

  final String title;
  final bool isChecked;
  final DateTime date;
  Function(bool? value) onChanged;

  List colors = [kGreenColor.withOpacity(0.35), kYellowColor.withOpacity(0.35)];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: kNormalTextStyle.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      tileColor: isChecked
          ? Color.fromARGB(255, 218, 218, 218)
          : colors[Random().nextInt(colors.length).toInt()],
      leading: Checkbox(
          checkColor: kGreenColor,
          activeColor: kDarkYellowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          value: isChecked,
          onChanged: isChecked ? (value) {} : onChanged),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              isChecked
                  ? showSnackbar(
                      context, 'You cannot edit a completed todo item')
                  : showDialogBox(context: context, screen: EditTodoScreen());
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      subtitle: Text(
        'Expires ${date.toString().substring(0, 10)}',
        style: kGreyNormalTextStyle.copyWith(fontSize: 12.0),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      contentPadding: EdgeInsets.all(5.0),
    );
  }
}


// Consumer<TodoProvider>(
                    //   builder: (context, value, child) {
                    //     // store all todos in a variaable
                    //     final todos = value.todos;

                    //     return ListView.builder(
                    //       itemCount: todos.length,
                    //       itemBuilder: (context, index) {
                    //         final todo = todos[index];
                    //         isChecked = todo.isCompleted;
                    //         return TodoItem(
                    //           title: todo.title,
                    //           isChecked: todo.isCompleted,
                    //           date: todo.expire,
                    //           onChanged: (value) {
                    //             setState(() {
                    //               isChecked = value!;
                    //             });
                    //           },
                    //         );
                    //       },
                    //     );
                    //   },
                    // child: TodoItem(
                    //   title: 'New Todo',
                    //   isChecked: isChecked,
                    //   date: DateTime.now(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       isChecked = value!;
                    //     });
                    //   },
                    // ),
                    // ),
                    // TodoItem(
                    //   title: 'New Todo',
                    //   isChecked: isChecked,
                    //   date: DateTime.now(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       isChecked = value!;
                    //     });
                    //   },
                    // ),


                    // child: Scaffold(
      //   backgroundColor: kBgColor,
      //   body: SingleChildScrollView(
      //     child: SafeArea(
      //       child: Padding(
      //         padding: kAppPadding,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             // App Bar
      //             Row(
      //               children: [
      //                 Expanded(
      //                   flex: 2,
      //                   child: Text(
      //                     '$greeting, First Name',
      //                     style: kOtherAppBarTextStyle.copyWith(
      //                         color: kGreenColor),
      //                   ),
      //                 ),
      //                 SizedBox(width: 10.0),
      //                 Expanded(
      //                   flex: 0,
      //                   child: CircleAvatar(
      //                     backgroundColor: kGreenColor,
      //                   ),
      //                 ),
      //               ],
      //             ), // End App Bar

      //             Divider(thickness: 2.0),
      //             SizedBox(height: 10.0),

      //             // Main Body
      //             Text(
      //               'First Name, here are your todos',
      //               style: kGreyNormalTextStyle,
      //             ),

      //             SizedBox(height: 20.0),

      //             Row(
      //               children: [
      //                 Expanded(flex: 1, child: SizedBox()),
      //                 Expanded(
      //                   flex: 1,
      //                   child: ButtonIcon(
      //                     buttonText: 'Add Todo',
      //                     buttonColor: kGreenColor,
      //                     onPressed: () {
      //                       showDialogBox(
      //                         context: context,
      //                         screen: AddTodoScreen(),
      //                       );
      //                     },
      //                     icon: FontAwesomeIcons.plus,
      //                   ),
      //                 ),
      //               ],
      //             ),

      //             SizedBox(height: 20.0),

      //             // Todos
      //             // Use the provider package to consume state
      //             Consumer<TodoProvider>(
      //               builder: (context, value, child) {
      //                 // store all todos in a variaable
      //                 final todos = value.todos;

      //                 return ListView.builder(
      //                   itemCount: todos.length,
      //                   itemBuilder: (context, index) {
      //                     final todo = todos[index];
      //                     isChecked = todo.isCompleted;
      //                     return TodoItem(
      //                       title: todo.title,
      //                       isChecked: todo.isCompleted,
      //                       date: todo.expire,
      //                       onChanged: (value) {
      //                         setState(() {
      //                           isChecked = value!;
      //                         });
      //                       },
      //                     );
      //                   },
      //                 );
      //               },
      //               // child: TodoItem(
      //               //   title: 'New Todo',
      //               //   isChecked: isChecked,
      //               //   date: DateTime.now(),
      //               //   onChanged: (value) {
      //               //     setState(() {
      //               //       isChecked = value!;
      //               //     });
      //               //   },
      //               // ),
      //             ),
      //             // TodoItem(
      //             //   title: 'New Todo',
      //             //   isChecked: isChecked,
      //             //   date: DateTime.now(),
      //             //   onChanged: (value) {
      //             //     setState(() {
      //             //       isChecked = value!;
      //             //     });
      //             //   },
      //             // ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),