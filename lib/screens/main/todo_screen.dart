// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'dart:developer' as dev;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  static const String id = 'todo';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Random random = Random();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: IsarService().getUserDetails(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       // check if snapshot has an error
    //       if (snapshot.hasError) {
    //         dev.log('Snapshot Error -- ${snapshot.error}');

    //         return ErrorLoadingScreen();
    //       } else {
    //         final User? user = snapshot.data;

    return Consumer<User?>(
      builder: (context, user, _) {
        return Scaffold(
          backgroundColor: kBgColor,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: kAppPadding,
                child: user == null
                    ? ErrorLoadingScreen()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main Body
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'My Todos',
                                  style: kAppBarTextStyle.copyWith(
                                    color: kGreyTextColor,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconTextButton(
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
                            ],
                          ),

                          SizedBox(height: 5.0),
                          Divider(thickness: 1, color: kGreenColor),
                          SizedBox(height: 10.0),

                          // Todos
                          // SingleChildScrollView(
                          //   child: SizedBox(
                          //     height: 500.0,
                          //     child: ListView.builder(
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
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
    //     }
    //   } else {
    //     return LoadingScreen(color: kGreenColor);
    //   }
    // },
    // );
  }
}
