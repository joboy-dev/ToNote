// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  static const String id = 'edit note';

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  String title = '';
  String content = '';

  bool readonly = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        readonly: readonly,
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
                      child: readonly
                          ? IconTextButton(
                              text: 'Edit',
                              icon: Icons.edit,
                              iconColor: kYellowColor,
                              fontSize: 15.0,
                              onPressed: () {
                                setState(() {
                                  readonly = false;
                                });
                              },
                            )
                          : IconTextButton(
                              text: 'Save',
                              icon: Icons.save_rounded,
                              iconColor: kYellowColor,
                              fontSize: 15.0,
                              onPressed: () {
                                // Implement save functionality
                                setState(() {
                                  readonly = true;
                                });
                                // navigatorPop(context);
                              },
                            ),
                    ),
                  ],
                ),

                Divider(),
                SizedBox(height: 10.0),

                // Text area field
                TextareaTextField(
                  hintText: 'Type a note...',
                  readonly: readonly,
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
