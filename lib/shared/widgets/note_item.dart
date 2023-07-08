// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/note/note_view.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/provider/notes_provider.dart';
import 'package:todoey/screens/main/edit_note_screen.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

class NoteItem extends StatefulWidget {
  NoteItem({
    super.key,
    // required this.title,
    // required this.content,
    // required this.noteId,
    required this.indexId,
  });

  /* 
  todoId and indexId are very important!!!!

  todoId will be used to update a todo on the backend
  indexId will be used to retrieve data directly from the list of todos in
  provider 
  */

  // int noteId;
  int indexId;
  // final String title;
  // final String content;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late Color color;

  List colors = [
    kGreenColor,
    kYellowColor,
    kDarkYellowColor,
    kOrangeColor,
    Color.fromARGB(255, 142, 184, 255),
    Color.fromARGB(255, 218, 224, 129),
    Color.fromARGB(255, 255, 184, 184),
  ];

  @override
  void initState() {
    color = colors[Random().nextInt(colors.length).toInt()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _noteView = NoteView();
    final _isarService = IsarService();
    final notes = Provider.of<NoteProvider?>(context)?.notes;

    bool _isLoading = false;
    String message = '';

    // access a note with the index id provided
    Note note = notes![widget.indexId];

    deleteNote() async {
      setState(() {
        _isLoading = true;
        message = 'Deleting note ${note.title}...';
      });
      showSnackbar(context, message);

      var data = await _noteView.deleteNote(
        id: note.id!,
      );

      if (data is Map) {
        await _isarService.deleteNote(note.id!);
        await _isarService.getUserNotes(context);

        setState(() {
          _isLoading = false;
          message = 'Note deleted.';
        });
      } else {
        setState(() {
          _isLoading = false;
          message = 'Something went wrong. Try again.';
        });
      }
      showSnackbar(context, message);
    }

    return Card(
      color: kBgColor,
      elevation: 0.0,
      child: Column(
        children: [
          _isLoading ? Loader(size: 25.0, color: kYellowColor) : SizedBox(),
          ListTile(
            title: Text(
              // '${widget.noteId}- ${widget.title}',
              '${note.title}',
              style: kNormalTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            tileColor: color,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EditNoteScreen(providerNoteId: widget.indexId),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                  color: Color.fromARGB(136, 0, 0, 0),
                ),
                IconButton(
                  onPressed: () {
                    deleteNote();
                  },
                  icon: Icon(Icons.delete),
                  color: Color.fromARGB(136, 0, 0, 0),
                ),
              ],
            ),
            subtitle: Text(
              '${note.content?.substring(0, 15)}...',
              style: kNormalTextStyle.copyWith(
                  fontSize: 12.0, color: Colors.black.withOpacity(0.6)),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding: EdgeInsets.only(left: 20.0),
          ),
          SizedBox(height: 3.0),
        ],
      ),
    );
  }
}
