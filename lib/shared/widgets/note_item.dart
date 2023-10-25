// ignore_for_file: use_build_context_synchronously

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
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
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

  final int indexId;
  // int noteId;
  // final String title;
  // final String content;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late Color color;
  late Color borderColor;

  List colors = [
    kGreenColor,
    kYellowColor,
    kDarkYellowColor,
    kOrangeColor,
    const Color.fromARGB(255, 142, 184, 255),
    const Color.fromARGB(255, 218, 224, 129),
    const Color.fromARGB(255, 255, 184, 184),
  ];

  @override
  void initState() {
    Color mainColor = colors[Random().nextInt(colors.length).toInt()];
    color = mainColor.withOpacity(0.25);
    borderColor = mainColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noteView = NoteView();
    final isarService = IsarService();
    final notes = Provider.of<NoteProvider?>(context)?.notes;

    bool isLoading = false;
    String message = '';

    // access a note with the index id provided
    Note note = notes![widget.indexId];

    deleteNote() async {
      setState(() {
        isLoading = true;
        message = 'Deleting note ${note.title}...';
      });
      showSnackbar(context, message);

      var data = await noteView.deleteNote(
        id: note.id!,
      );

      if (data is Map) {
        await isarService.deleteNote(note.id!);
        await isarService.getUserNotes(context);

        setState(() {
          isLoading = false;
          message = 'Note deleted.';
        });
      } else {
        setState(() {
          isLoading = false;
          message = 'Something went wrong. Try again.';
        });
      }
      showSnackbar(context, message);
    }

    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      child: Column(
        children: [
          isLoading ? const Loader(size: 25.0, color: kYellowColor) : const SizedBox(),
          ListTile(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: borderColor, 
              width: 1.0,
            )
          ),
            title: Text(
              // '${widget.noteId}- ${widget.title}',
              '${note.title}',
              style: kNormalTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kFontTheme(context),
              ),
            ),
            tileColor: color,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    navigatorPush(context, EditNoteScreen(providerNoteId: widget.indexId));
                  },
                  icon: const Icon(Icons.edit),
                  color: kFontTheme(context),
                ),
                IconButton(
                  onPressed: () {
                    deleteNote();
                  },
                  icon: const Icon(Icons.delete),
                  color: kFontTheme(context),
                ),
              ],
            ),
            subtitle: Text(
              '${note.content?.substring(0, 15)}...',
              style: kNormalTextStyle.copyWith(
                  fontSize: 12.0, color: kFontTheme(context)),
            ),
            contentPadding: const EdgeInsets.only(left: 20.0),
          ),
          const SizedBox(height: 3.0),
        ],
      ),
    );
  }
}
