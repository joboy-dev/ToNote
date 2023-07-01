// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/add_notes_screen.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/screens/main/todo_screen.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/services/timer.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  math.Random random = math.Random();
  bool isChecked = false;

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
    return Consumer<User?>(
      builder: (context, user, _) {
        return user == null
            ? LoadingScreen(color: kOrangeColor)
            : Scaffold(
                backgroundColor: kBgColor,
                body: SingleChildScrollView(
                  child: RefreshIndicator(
                    onRefresh: () async {},
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
                                    'My Latest Todos',
                                    style: kAppBarTextStyle.copyWith(
                                      color: kGreyTextColor,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Expanded(
                                  flex: 1,
                                  child: IconTextButton(
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
                              ],
                            ),

                            SizedBox(height: 5.0),
                            Divider(thickness: 1, color: kOrangeColor),
                            SizedBox(height: 10.0),

                            // Todos
                            RefreshIndicator(
                              onRefresh: () async {},
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  height: 210.0,
                                  child: ListView(
                                    children: [
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                      Text('Todos'),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20.0),

                            // NOTES
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'My Latest Notes',
                                    style: kAppBarTextStyle.copyWith(
                                      color: kGreyTextColor,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Expanded(
                                  flex: 1,
                                  child: IconTextButton(
                                    text: 'New',
                                    fontWeight: FontWeight.bold,
                                    icon: FontAwesomeIcons.plus,
                                    iconColor: kOrangeColor,
                                    textColor: kOrangeColor,
                                    fontSize: 17.0,
                                    gap: 20.0,
                                    onPressed: () {
                                      navigatorPushReplacementNamed(
                                          context, AddNotesScreen.id);
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5.0),
                            Divider(thickness: 1, color: kOrangeColor),
                            SizedBox(height: 10.0),

                            // Notes
                            SingleChildScrollView(
                              child: SizedBox(
                                height: 210.0,
                                child: ListView(
                                  children: [
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                    Text('Todos'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
