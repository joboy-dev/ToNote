// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'dart:developer' as dev;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/models/user.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/dialog_screens/add_todo.dart';
import 'package:todoey/screens/main/dialog_screens/edit_todo.dart';
import 'package:todoey/services/shared_preferences/user_shared_preferences.dart';
import 'package:todoey/services/user/user_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  static const String id = 'todo';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Random random = Random();
  DateTime now = DateTime.now();
  String greeting = '';
  bool isChecked = false;

  // map to store cached user data
  Map<String, dynamic> _cachedUserData = {};

  final UserView _userView = UserView();

  final UserSharedPreferences _userSharedPreferences = UserSharedPreferences();

  // initialize user provider
  UserProvider _userProvider = UserProvider();

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

  // Function to get current logged in user details
  // _getUserDetails() async {
  //   // get user data
  //   var data = await _userView.getUserDetails();

  //   // check if user data was successfully fetched to prevent errors
  //   if (data != 400 &&
  //       data != 401 &&
  //       data != 'Connection timed out' &&
  //       data != null) {
  //     dev.log('User Data from gotten user details (TodoScreen) -- $data');

  //     // get user profile picture
  //     var profilePic = await _userView.getUserProfilePicture();

  //     // cache user data
  //     _userSharedPreferences.cacheUserDetails(
  //       firstName: data['first_name'],
  //       lastName: data['last_name'],
  //       email: data['email'],
  //       profilePicture: profilePic['profile_pic'],
  //     );

  //     // create a new user instance for provider package
  //     User user = User(
  //       firstName: data['first_name'],
  //       lastName: data['last_name'],
  //       email: data['email'],
  //       profilePicture: profilePic['profile_pic'],
  //     );

  //     // set user details in provider so you can make use of it on the frontend
  //     dev.log('Setting user details in provider package');
  //     _userProvider.setUser(user);

  //     // check if user provider works
  //     dev.log(
  //         '(TodoScreen) User Provider Testing -- ${_userProvider.user!.profilePicture}');

  //     // set user details in cache
  //     dev.log('Setting user details in shared preferences cache');
  //     _cachedUserData = await _userSharedPreferences.getCachedUserData();
  //     dev.log('(TodoScreen) Cached user data -- $_cachedUserData');
  //   } else if (data == 'Connection timed out') {
  //     dev.log(
  //         'Error -- User Data from gotten user details (TodoScreen) -- $data');
  //   }
  // }

  Future<Map<String, dynamic>> _getCachedData() async {
    // get user cached data
    Map<String, dynamic> _cachedData =
        await _userSharedPreferences.getCachedUserData();

    dev.log('(HomeScreen) Cached User Data -- $_cachedData');

    User user = User(
      firstName: _cachedData['first_name'],
      lastName: _cachedData['last_name'],
      email: _cachedData['email'],
      profilePicture: _cachedData['profile_pic'],
    );

    _userProvider.setUser(user);

    // Testing provider
    dev.log('User provider test -- ${_userProvider.user!.firstName}');

    return _cachedData;
  }

  @override
  void initState() {
    getGreeting();
    // _getUserDetails();
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
            dev.log('Snapshot Error -- ${snapshot.error}');

            return ErrorLoadingScreen();
          } else {
            // Get user details from provider
            final user = _userProvider.user;

            // Get todos provider from context
            final todoProvider = Provider.of<TodoProvider>(context);

            // store all todos in a variable
            final todos = todoProvider.todos;

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
                                    child: ButtonIcon(
                                      buttonText: 'New',
                                      onPressed: () {
                                        showDialogBox(
                                          context: context,
                                          dismisible: false,
                                          screen: AddTodoScreen(),
                                        );
                                      },
                                      buttonColor: kGreenColor,
                                      icon: FontAwesomeIcons.plus,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5.0),
                              Divider(thickness: 1, color: kGreenColor),
                              SizedBox(height: 10.0),

                              // Todos
                              SingleChildScrollView(
                                child: SizedBox(
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
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            );
          }
        } else {
          return LoadingScreen(color: kGreenColor);
        }
      },
    );
  }
}
