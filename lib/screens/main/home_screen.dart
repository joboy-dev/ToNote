// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/models/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/screens/main/todo_screen.dart';
import 'package:todoey/services/shared_preferences/user_shared_preferences.dart';
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
  DateTime now = DateTime.now();
  String greeting = '';
  bool isChecked = false;

  // map to store cached user data
  Map<String, dynamic> _cachedUserData = {};

  final UserView _userView = UserView();

  final UserSharedPreferences _userSharedPreferences = UserSharedPreferences();

  // initialize user provider
  final UserProvider _userProvider = UserProvider();

  // Function to get the appropriate greeting
  getGreeting() {
    if (now.hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (now.hour >= 12 && now.hour < 17) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  Future<Map<String, dynamic>> _getCachedData() async {
    // get user cached data
    Map<String, dynamic> _cachedData =
        await _userSharedPreferences.getCachedUserData();

    log('(HomeScreen) Cached User Data -- $_cachedData');

    User user = User(
      firstName: _cachedData['first_name'],
      lastName: _cachedData['last_name'],
      email: _cachedData['email'],
      profilePicture: _cachedData['profile_pic'],
    );

    _userProvider.setUser(user);

    // Testing provider
    log('User provider test -- ${_userProvider.user!.firstName}');

    return _cachedData;
  }

  @override
  void initState() {
    getGreeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCachedData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // check if snapshot has an error
          if (snapshot.hasError) {
            log('Snapshot Error -- ${snapshot.error}');

            return ErrorLoadingScreen();
          } else {
            // Get user details from provider
            final user = _userProvider.user;

            // Get todos provider from context
            // final todoProvider = Provider.of<TodoProvider>(context);

            // // store all todos in a variable
            // final todos = todoProvider.todos;

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
                                    child: ButtonIcon(
                                      buttonText: 'New',
                                      onPressed: () {
                                        showDialogBox(
                                          context: context,
                                          dismisible: false,
                                          screen: AddTodoScreen(),
                                        );
                                        // navigatorPushNamed(
                                        //     context, TodoScreen.id);
                                      },
                                      buttonColor: kOrangeColor,
                                      // inactive: false
                                      icon: FontAwesomeIcons.plus,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5.0),
                              Divider(thickness: 1, color: kOrangeColor),
                              SizedBox(height: 10.0),

                              // Todos
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

                              // NOTES
                              Row(
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
                                    child: ButtonIcon(
                                      buttonText: 'New',
                                      onPressed: () {
                                        showDialogBox(
                                          context: context,
                                          dismisible: false,
                                          screen: AddTodoScreen(),
                                        );
                                      },
                                      buttonColor: kOrangeColor,
                                      icon: FontAwesomeIcons.plus,
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
                  );
          }
        } else {
          return LoadingScreen(color: kOrangeColor);
        }
      },
    );
  }
}
