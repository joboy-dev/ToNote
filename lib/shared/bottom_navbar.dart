// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isar/isar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:todoey/entities/user.dart';
import 'package:todoey/provider/device_prefs_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/add_notes_screen.dart';
import 'package:todoey/screens/main/add_profile_picture_screen.dart';
import 'package:todoey/screens/main/edit_note_screen.dart';
import 'package:todoey/screens/main/home_screen.dart';
import 'package:todoey/screens/main/loading_data_screen.dart';
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
  PersistentTabController? _controller;
  bool? _hideNavBar;
  int _index = 0;

  DateTime now = DateTime.now();
  String greeting = '';

  // Function to get the appropriate greeting
  _getGreeting() {
    if (now.hour >= 0 && now.hour < 12) {
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

  // List of persistent nav bar items
  List<PersistentBottomNavBarItem> _navBarsItems() => [
        // PersistentBottomNavBarItem(
        //   icon: const Icon(Icons.home),
        //   title: "Home",
        //   activeColorPrimary: kBgColor,
        //   inactiveColorPrimary: kGreyTextColor,
        //   routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //     initialRoute: HomeScreen.id,
        //     routes: {
        //       AddNotesScreen.id: (context) => AddNotesScreen(),
        //       EditNoteScreen.id: (context) => EditNoteScreen(),
        //       LoadingDataScreen.id: (context) => LoadingDataScreen(),
        //     },
        //   ),
        // ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.checklist_rounded),
          title: "Todo",
          activeColorPrimary: kBgColor,
          inactiveColorPrimary: kGreyTextColor,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: TodoScreen.id,
            routes: {
              AddNotesScreen.id: (context) => AddNotesScreen(),
              EditNoteScreen.id: (context) => EditNoteScreen(),
              LoadingDataScreen.id: (context) => LoadingDataScreen(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.noteSticky),
          title: "Notes",
          activeColorPrimary: kBgColor,
          inactiveColorPrimary: kGreyTextColor,
          // Adding routes
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: NotesScreen.id,
            routes: {
              AddNotesScreen.id: (context) => AddNotesScreen(),
              EditNoteScreen.id: (context) => EditNoteScreen(),
              LoadingDataScreen.id: (context) => LoadingDataScreen(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "Profile",
          activeColorPrimary: kBgColor,
          inactiveColorPrimary: kGreyTextColor,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: ProfileScreen.id,
            routes: {
              AddProfilePicture.id: (context) => AddProfilePicture(),
              LoadingDataScreen.id: (context) => LoadingDataScreen(),
            },
          ),
        ),
      ];

  List<Widget> _buildScreens() => [
        // HomeScreen(),
        TodoScreen(),
        NotesScreen(),
        ProfileScreen(),
      ];

  List<Color> colors = [
    // kOrangeColor,
    kGreenColor,
    kYellowColor,
    kDarkYellowColor
  ];

  @override
  void initState() {
    _getGreeting();
    _controller = PersistentTabController();
    _hideNavBar = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    final prefsDarkMode = Provider.of<DevicePrefsProvider>(context).darkMode;

    setState(() {
      kBgColor = prefsDarkMode
          ? Color(0xff1E1E1E)
          : Color.fromARGB(255, 250, 250, 250);
    });

    log('Bottom nav bar test -- ${user?.firstName}');

    List<PreferredSizeWidget> appBars() => user == null
        ? [
            CustomAppBar(
              textColor: kOrangeColor,
              appBarText: 'Loading...',
              imageUrl: user?.profilePicture,
              appBarColor: kBgColor,
            ),
          ]
        : [
            // CustomAppBar(
            //   textColor: kOrangeColor,
            //   appBarText: '$greeting, ${user.firstName}',
            //   imageUrl: user.profilePicture,
            //   appBarColor: kBgColor,
            // ),
            CustomAppBar(
              textColor: kGreenColor,
              appBarText: '$greeting, ${user.firstName}',
              imageUrl: user.profilePicture,
              appBarColor: kBgColor,
            ),
            CustomAppBar(
              textColor: kYellowColor,
              appBarText: '$greeting, ${user.firstName}',
              imageUrl: user.profilePicture,
              appBarColor: kBgColor,
            ),
            CustomAppBar(
              textColor: kDarkYellowColor,
              otherAppBarText: 'My Profile',
              appBarColor: kBgColor,
            ),
          ];

    return Scaffold(
      appBar: appBars()[_index],
      body: user == null
          ? LoadingScreen(color: kOrangeColor)
          : PersistentTabView(
              context,
              controller: _controller,
              screens: _buildScreens(),
              items: _navBarsItems(),
              resizeToAvoidBottomInset: true,
              navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                  ? 0.0
                  : kBottomNavigationBarHeight,
              bottomScreenMargin: 0,
              backgroundColor: colors[_index],
              hideNavigationBar: _hideNavBar,
              decoration: NavBarDecoration(
                colorBehindNavBar: kGreyTextColor,
                border: Border(
                  top: BorderSide(
                    color: kGreyTextColor,
                    width: 3.0,
                  ),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: kBgColor,
                //     offset: Offset(1.0, 4.0),
                //     blurStyle: BlurStyle.solid,
                //   )
                // ]
              ),
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
              navBarStyle: NavBarStyle.style11,
              onItemSelected: (value) {
                setState(() {
                  _index = value;
                });
              },
            ),
    );
  }
}
