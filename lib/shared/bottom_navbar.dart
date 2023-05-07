// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/models/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/home_screen.dart';
import 'package:todoey/screens/main/notes_screen.dart';
import 'package:todoey/screens/main/profile_screen.dart';
import 'package:todoey/screens/main/todo_screen.dart';
import 'package:todoey/services/shared_preferences/user_shared_preferences.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loading_screen.dart';

import 'custom_appbar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const String id = 'navbar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final UserSharedPreferences _userSharedPreferences = UserSharedPreferences();

  // initialize user provider
  final UserProvider _userProvider = UserProvider();

  math.Random random = math.Random();
  DateTime now = DateTime.now();
  String greeting = '';
  bool isChecked = false;

  // Function to get the appropriate greeting
  _getGreeting() {
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

    log('(BottomNavBar) Cached User Data -- $_cachedData');

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

  int _index = 0;

  // List of icon items
  final List<Widget> _items = [
    Icon(
      Icons.home,
      semanticLabel: 'Todo',
      size: 30.0,
      color: kBgColor,
    ),
    Icon(
      Icons.check_circle_outline,
      semanticLabel: 'Todo',
      size: 30.0,
      color: kBgColor,
    ),
    Icon(
      Icons.note,
      semanticLabel: 'Notes',
      size: 30.0,
      color: kBgColor,
    ),
    Icon(
      Icons.person,
      semanticLabel: 'Profile',
      size: 30.0,
      color: kBgColor,
    )
  ];

  // List of screens
  List screens = [HomeScreen(), TodoScreen(), NotesScreen(), ProfileScreen()];

  // List of colors that will be used for each screen
  List colors = [kOrangeColor, kGreenColor, kYellowColor, kDarkYellowColor];

  // create a list of navigator keys
  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    _getGreeting();
    _getCachedData();
    super.initState();
  }

  // widget function to monitor changes to screens in the navbar in case if
  // a button is tapped off the navbar stage
  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _index != index,
      child: Navigator(
        key: navigatorKeys[index],
        onGenerateRoute: (routeSettings) =>
            MaterialPageRoute(builder: (_) => screens[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCachedData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return ErrorLoadingScreen();
          } else {
            final user = _userProvider.user;

            if (user == null) {
              return ErrorLoadingScreen();
            } else {
              List<CustomAppBar> appBars = [
                CustomAppBar(
                  textColor: kOrangeColor,
                  appBarText: '$greeting, ${user.firstName}',
                  imageUrl: user.profilePicture,
                ),
                CustomAppBar(
                  textColor: kGreenColor,
                  appBarText: '$greeting, ${user.firstName}',
                  imageUrl: user.profilePicture,
                ),
                CustomAppBar(
                  textColor: kYellowColor,
                  appBarText: '$greeting, ${user.firstName}',
                  imageUrl: user.profilePicture,
                ),
                CustomAppBar(
                  textColor: kDarkYellowColor,
                  otherAppBarText: 'My Profile',
                ),
              ];
              return Scaffold(
                appBar: appBars[_index],
                body: Stack(
                  children: [
                    _buildOffstageNavigator(0),
                    _buildOffstageNavigator(1),
                    _buildOffstageNavigator(2),
                    _buildOffstageNavigator(3),
                  ],
                ),
                bottomNavigationBar: CurvedNavigationBar(
                  items: _items,
                  index: _index,
                  color: colors[_index],
                  backgroundColor: kBgColor,
                  height: 75.0,
                  animationCurve: Curves.easeIn,
                  animationDuration: Duration(milliseconds: 300),
                  onTap: (value) {
                    setState(() {
                      // assign current index the value in the on tap function
                      _index = value;
                    });
                  },
                ),
                // body: screens[_index],
              );
            }
          }
        } else {
          return LoadingScreen(color: kOrangeColor);
        }
      },
    );
  }
}
