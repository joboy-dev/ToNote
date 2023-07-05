// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  static const String id = 'add note';

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  String title = '';
  String content = '';
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Head containing title text field
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: NormalTextField(
                        hintText: 'Title',
                        fontSize: 17.0,
                        onChanged: (value) {
                          setState(() {
                            title = '$value';
                          });
                        },
                        enabledBorderColor: Colors.transparent,
                        focusedBorderColor: Colors.transparent,
                        errorBorderColor: Colors.transparent,
                        focusedErrorBorderColor: Colors.transparent,
                        errorTextStyleColor: kDarkYellowColor,
                        iconColor: kYellowColor,
                        cursorColor: kYellowColor,
                        prefixIcon: FontAwesomeIcons.solidNoteSticky,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconTextButton(
                        text: 'Save',
                        icon: Icons.save_rounded,
                        iconColor: kYellowColor,
                        fontSize: 15.0,
                        onPressed: () {
                          navigatorPop(context);
                        },
                      ),
                    ),
                  ],
                ),

                Divider(color: kYellowColor),
                SizedBox(height: 10.0),

                // Text area field
                TextareaTextField(
                  hintText: 'Type a note...',
                  onChanged: (value) {
                    setState(() {
                      content = '$value';
                    });
                  },
                  errorTextStyleColor: kDarkYellowColor,
                  cursorColor: kYellowColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
