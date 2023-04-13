// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/screens/main/notes_screen.dart';
import 'package:todoey/screens/main/profile_screen.dart';
import 'package:todoey/screens/main/todo_screen.dart';
import 'package:todoey/shared/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const String id = 'navbar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  // List of icon items
  final List<Widget> _items = [
    Icon(FontAwesomeIcons.check, semanticLabel: 'Todo'),
    Icon(FontAwesomeIcons.noteSticky, semanticLabel: 'Notes'),
    Icon(FontAwesomeIcons.person, semanticLabel: 'Profile')
  ];

  // List of screens
  List screens = [TodoScreen(), NotesScreen(), ProfileScreen()];

  // List of colors that will be used for each screen
  List colors = [kGreenColor, kYellowColor, kDarkYellowColor];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: _items,
        index: _index,
        backgroundColor: colors[_index],
        height: 40.0,
        animationCurve: Curves.bounceInOut,
        onTap: (value) {
          setState(() {
            // assign current index the value in the on tap function
            _index = value;
          });
        },
      ),
      body: screens[_index],
    );
  }
}
