// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/note/note_view.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/entities/todo.dart';
import 'package:todoey/provider/notes_provider.dart';
import 'package:todoey/provider/todo_provider.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/snackbar.dart';
import 'package:todoey/shared/widgets/text_field.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({super.key, required this.providerNoteId});

  static const String id = 'edit note';

  int providerNoteId;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? content;

  bool readonly = true;

  bool _isLoading = false;
  String message = '';

  final _isarService = IsarService();
  final _noteView = NoteView();

  @override
  Widget build(BuildContext context) {
    // get all todos from provider
    final notes = Provider.of<NoteProvider?>(context)?.notes;

    // get a single todo based on the index id of a todo passed into this screen
    // from provider
    Note note = notes![widget.providerNoteId];

    log('Editnote dialog provider note id -- ${widget.providerNoteId}');
    log('Editnote dialog index note id -- ${note.id}');

    validateForm() async {
      if (_formKey.currentState!.validate()) {
        if (title == content) {
          setState(() {
            message = 'Title and content cannot be the same';
          });
        } else {
          NoteModel _note = NoteModel(
            title: title ?? '${note.title}',
            content: content ?? '${note.content}',
          );

          setState(() {
            _isLoading = true;
          });

          // perform adding todo function
          var data = await _noteView.updateNote(note: _note, id: note.id!);

          if (data is Note) {
            await _isarService.saveNote(data, context);
            await _isarService.getUserNotes(context);

            setState(() {
              _isLoading = false;
              message = 'Note edited.';
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
                          initialValue: note.title,
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
                            : _isLoading
                                ? Loader(
                                    size: 20.0,
                                    color: kYellowColor,
                                  )
                                : IconTextButton(
                                    text: 'Save',
                                    icon: Icons.save_rounded,
                                    iconColor: kYellowColor,
                                    fontSize: 15.0,
                                    onPressed: () async {
                                      // Implement save functionality
                                      await validateForm();
                                      setState(() {
                                        readonly = true;
                                      });
                                    },
                                  ),
                      ),
                    ],
                  ),

                  Divider(color: kYellowColor),
                  SizedBox(height: 10.0),

                  // Text area field
                  TextareaTextField(
                    initialValue: note.content,
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
      ),
    );
  }
}
