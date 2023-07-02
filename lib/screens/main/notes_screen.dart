// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/add_notes_screen.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  static const String id = 'notes';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    return user == null
        ? ErrorLoadingScreen()
        : Scaffold(
            backgroundColor: kBgColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: kAppPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Body
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'My Notes',
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
                              iconColor: kYellowColor,
                              textColor: kYellowColor,
                              fontSize: 17.0,
                              gap: 20.0,
                              onPressed: () {
                                navigatorPushNamed(
                                    context, AddNotesScreen.id);
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.0),
                      Divider(thickness: 1, color: kYellowColor),
                      SizedBox(height: 10.0),

                      // Todos
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 500.0,
                          // child: ListView.builder(
                          //   itemCount: todos.length,
                          //   itemBuilder: (context, index) {
                          //     final todo = todos[index];
                          //     isChecked = todo.isCompleted;
                          //     return TodoItem(
                          //       title: todo.title,
                          //       isChecked: todo.isCompleted,
                          //       date: todo.expire,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           isChecked = value!;
                          //         });
                          //       },
                          //     );
                          //   },
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
