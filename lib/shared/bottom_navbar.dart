import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/home_screen.dart';
import 'package:todoey/screens/main/notes_screen.dart';
import 'package:todoey/screens/main/profile_screen.dart';
import 'package:todoey/screens/main/todo_screen.dart';
import 'package:todoey/shared/animations.dart';
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
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home, size: 30.sp),
          title: "Home",
          activeColorPrimary: kScaffoldBgColor(context),
          inactiveColorPrimary: kScaffoldBgColor(context).withOpacity(0.3),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.checklist_rounded, size: 30.sp),
          title: "Todo",
          activeColorPrimary: kScaffoldBgColor(context),
          inactiveColorPrimary: kScaffoldBgColor(context).withOpacity(0.3),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.noteSticky, size: 30.sp),
          title: "Notes",
          activeColorPrimary: kScaffoldBgColor(context),
          inactiveColorPrimary: kScaffoldBgColor(context).withOpacity(0.3),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person, size: 30.sp),
          title: "Profile",
          activeColorPrimary: kScaffoldBgColor(context),
          inactiveColorPrimary: kScaffoldBgColor(context).withOpacity(0.3),
        ),
      ];

  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const TodoScreen(),
        const NotesScreen(),
        const ProfileScreen(),
      ];

  List<Color> colors = [
    kOrangeColor,
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
    log('Bottom nav bar test -- ${user?.firstName}');

    List<PreferredSizeWidget> appBars() => user == null
        ? [
            CustomAppBar(
              textColor: kOrangeColor,
              appBarText: 'Loading...',
              imageUrl: user?.profilePicture,
            ),
            CustomAppBar(
              textColor: kGreenColor,
              appBarText: 'Loading...',
              imageUrl: user?.profilePicture,
            ),
            CustomAppBar(
              textColor: kYellowColor,
              appBarText: 'Loading...',
              imageUrl: user?.profilePicture,
            ),
            CustomAppBar(
              textColor: kDarkYellowColor,
              appBarText: 'Loading...',
              imageUrl: user?.profilePicture,
            ),
          ]
        : [
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
            const CustomAppBar(
              textColor: kDarkYellowColor,
              otherAppBarText: 'My Profile',
            ),
          ];

    return Scaffold(
      // backgroundColor: kBgColor,
      appBar: appBars()[_index],
      body: user == null
          ? const LoadingScreen(color: kOrangeColor)
          : PersistentTabView(
              context,
              controller: _controller,
              screens: _buildScreens(),
              items: _navBarsItems(),
              resizeToAvoidBottomInset: true,
              navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                  ? 0.0
                  : 50.h,
              bottomScreenMargin: 0,
              backgroundColor: colors[_index],
              hideNavigationBar: _hideNavBar,
              decoration: const NavBarDecoration(
                colorBehindNavBar: kGreyTextColor,
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
            ).animate(
              effects: MyEffects.fadeSlide()
            ),
    );
  }
}
