// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/button.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Random random = Random();
  DateTime now = DateTime.now();
  String timeOfDay = '';

  bool isChecked = false;

  List colors = [kGreenColor.withOpacity(0.35), kYellowColor.withOpacity(0.35)];
  List images = ['1.png', '2.jpg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        DateTime.now().hour < 12
                            ? 'Good Morning'
                            : (DateTime.now().hour >= 12 &&
                                    DateTime.now().hour < 17
                                ? 'Good Afternoon'
                                : 'Good Evening'),
                        style:
                            kOtherAppBarTextStyle.copyWith(color: kGreenColor),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 0,
                      child: CircleAvatar(
                        backgroundColor: kGreenColor,
                      ),
                    ),
                  ],
                ), // End App Bar

                Divider(thickness: 2.0),
                SizedBox(height: 10.0),

                // Main Body
                Text(
                  'First Name, here are your todos',
                  style: kGreyNormalTextStyle,
                ),

                SizedBox(height: 20.0),

                Row(
                  children: [
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: ButtonIcon(
                        buttonText: 'Add Todo',
                        buttonColor: kGreenColor,
                        onPressed: () {},
                        icon: FontAwesomeIcons.plus,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.0),

                // Todos
                ListTile(
                  title: Text(
                    'New Todo',
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    value: isChecked,
                    onChanged: isChecked
                        ? (value) {}
                        : (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ),
                  subtitle: Text(
                    'Expires ${now.day}/${now.month}/${now.year} - ${now.hour}:${now.minute}',
                    style: kGreyNormalTextStyle.copyWith(fontSize: 12.0),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: EdgeInsets.all(5.0),
                ),

                // Stack(
                //   children: [
                //     Positioned(
                //       right: 0,
                //       bottom: 40,
                //       width: 100,
                //       height: 100,
                //       child: Row(
                //         children: [
                //           Expanded(flex: 1, child: SizedBox()),
                //           Expanded(
                //             flex: 1,
                //             child: ButtonIcon(
                //               buttonText: 'Add Todo',
                //               buttonColor: kGreenColor,
                //               onPressed: () {},
                //               icon: FontAwesomeIcons.plus,
                //             ),
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
