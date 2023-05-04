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
import 'package:todoey/services/user/user_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
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
  bool isChecked = false;

  final UserView _userView = UserView();

  // initialize user provider
  UserProvider _userProvider = UserProvider();

  // Function to get the appropriate greeting
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

  // Function to get current logged in user details
  _getUserDetails() async {
    // get user data
    var data = await _userView.getUserDetails();

    if (data == 200) {
      dev.log('User Data from gotten user details (TodoScreen) -- $data');

      // get user profile picture
      var profilePic = await _userView.getUserProfilePicture();

      // create a new user instance
      User user = User(
        firstName: data['first_name'],
        lastName: data['last_name'],
        email: data['email'],
        profilePicture: profilePic['profile_pic'],
      );

      // set user details in provider so you can make use of it on the frontend
      _userProvider.setUser(user);

      // check if user provider worka
      dev.log('User Provider Testing -- ${_userProvider.user!.profilePicture}');
    } else if (data == 'Connection Timed out') {
      dev.log('User Data from gotten user details (TodoScreen) -- $data');
    }
  }

  @override
  void initState() {
    getGreeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: _userService.getUserDetails(),
      future: _getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // check if snapshot has an error
          if (snapshot.hasError) {
            dev.log('Snapshot Error -- ${snapshot.error}');

            return Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning,
                          size: 40.0,
                          color: kRedColor,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'We could not fetch your data at this time. Please check your network connection or try again later.',
                          style: kGreyNormalTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
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
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning,
                                size: 40.0,
                                color: kRedColor,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'We could not fetch your data at this time. Please check your network connection or try again later.',
                                style: kGreyNormalTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // App Bar
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      '$greeting, ${user.firstName}',
                                      style: kOtherAppBarTextStyle.copyWith(
                                        color: kGreenColor,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    flex: 0,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          kGreenColor.withOpacity(0.5),
                                      foregroundImage:
                                          NetworkImage(user.profilePicture),
                                    ),
                                  ),
                                ],
                              ), // End App Bar

                              Divider(thickness: 0.5),
                              SizedBox(height: 10.0),

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
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Loader(size: 40.0, color: kGreenColor),
                  Text(
                    'Fetching data',
                    style: kGreyNormalTextStyle,
                  ),
                ],
              ),
            ),
          );
        }
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

  List colors = [
    kGreenColor.withOpacity(0.35),
    kDarkYellowColor.withOpacity(0.35),
    Color.fromARGB(255, 142, 184, 255),
    Color.fromARGB(255, 250, 255, 184),
    Color.fromARGB(255, 255, 184, 184),
  ];

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

// var data = await _userView.getUserDetails();

// dev.log('Provider user -- $data');

// User userObject = User(
//   firstName: data['first_name'],
//   lastName: data['last_name'],
//   email: data['email'],
// );

// final userProvider = Provider.of<UserProvider>(context, listen: false);

// userProvider.setUser(userObject);
