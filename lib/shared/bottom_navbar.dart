// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/home_screen.dart';
import 'package:todoey/screens/main/notes_screen.dart';
import 'package:todoey/screens/main/profile_screen.dart';
import 'package:todoey/screens/main/todo_screen.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/services/timer.dart';
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
  LoadingTimer _loadingTimer = LoadingTimer();

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

  int _index = 0;

  // List of icon items
  final List<Widget> _items = [
    Icon(
      Icons.home,
      semanticLabel: 'Home',
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
      FontAwesomeIcons.noteSticky,
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
  void initState() {
    _getGreeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;

    log('Bottom nav bar test -- ${user?.firstName}');

    // if (user == null) {
    //   return LoadingScreen(color: kOrangeColor);
    // } else {
    List<CustomAppBar> appBars = [
      CustomAppBar(
        textColor: kOrangeColor,
        appBarText: '$greeting, ${user?.firstName}',
        imageUrl: user?.profilePicture,
      ),
      CustomAppBar(
        textColor: kGreenColor,
        appBarText: '$greeting, ${user?.firstName}',
        imageUrl: user?.profilePicture,
      ),
      CustomAppBar(
        textColor: kYellowColor,
        appBarText: '$greeting, ${user?.firstName}',
        imageUrl: user?.profilePicture,
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
  // }
}
