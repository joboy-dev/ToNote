// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/backend/note/note_view.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  static const String id = 'add note';

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String content = '';

  bool _isLoading = false;
  String message = '';

  final _isarService = IsarService();
  final _noteView = NoteView();

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      if (title == content) {
        setState(() {
          message = 'Title and content cannot be the same';
        });
      } else {
        NoteModel note = NoteModel(
          title: title,
          content: content,
        );

        setState(() {
          _isLoading = true;
        });

        // perform adding todo function
        var data = await _noteView.addNote(note: note);

        if (data is Note) {
          await _isarService.saveNote(data, context);

          setState(() {
            _isLoading = false;
            message = 'New note "$title" added.';
          });

          navigatorPop(context);
        } else if (data == 400) {
          setState(() {
            _isLoading = false;
            message = 'Something went wrong try again';
          });
        } else {
          setState(() {
            _isLoading = false;
            message = 'Something went wrong try again';
          });
        }
      }
      showSnackbar(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Form(
              key: _formKey,
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
                              title = value!;
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
                        child: _isLoading
                            ? const Loader(
                                size: 20.0,
                                color: kYellowColor,
                              )
                            : IconTextButton(
                                text: 'Save',
                                icon: Icons.save_rounded,
                                iconColor: kYellowColor,
                                fontSize: 15.0,
                                onPressed: () {
                                  validateForm();
                                },
                              ),
                      ),
                    ],
                  ),

                  const Divider(color: kYellowColor),
                  const SizedBox(height: 10.0),

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
      ),
    );
  }
}
