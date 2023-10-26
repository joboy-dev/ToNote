// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todoey/backend/note/note_view.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/provider/notes_provider.dart';
import 'package:todoey/services/isar_service.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/loader.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/dialog_header.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

class DeleteNoteScreen extends StatefulWidget {
  const DeleteNoteScreen({super.key, required this.providerTodoId});

  final int providerTodoId;

  @override
  State<DeleteNoteScreen> createState() => _DeleteNoteScreenState();
}

class _DeleteNoteScreenState extends State<DeleteNoteScreen> {
  bool _isLoading = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    final noteView = NoteView();
    final notes = Provider.of<NoteProvider?>(context)?.notes;

    Note note = notes![widget.providerTodoId];

    deleteNote() async {
      setState(() {
        _isLoading = true;
      });

      var data = await noteView.deleteNote(
        id: note.id!,
      );

      if (data is Map) {
        // await IsarService().savenote(data, context);
        await IsarService().deleteNote(note.id!);
        setState(() {
          _isLoading = false;
          message = 'Note deleted.';
        });
        await IsarService().getUserNotes(context);
        navigatorPop(context);

        showSnackbar(context, message);
      } else {
        setState(() {
          _isLoading = false;
          message = 'Something went wrong. Try again.';
        });
      }
    }

    return Column(
      children: [
        const DialogHeader(
          headerText: 'Delete Note',
          icon: Icons.delete_rounded,
          mainColor: kRedColor,
        ),
        const SizedBox(height: 10.0),

        Text("Are you sure you want to detele note '${note.title}'?",
            style: kGreyNormalTextStyle(context)),
        const SizedBox(height: 20.0),

        DoubleButton(
          inactiveButton: false,
          button2Text: 'Delete',
          button2Color: kGreenColor,
          button2onPressed: () async {
            deleteNote();
          },
        ),
        SizedBox(height: 10.h),
        _isLoading
            ? Loader(
                size: 20.r,
                color: kGreenColor,
              )
            : const SizedBox(),
        message.isEmpty
            ? const SizedBox(height: 0.0)
            : Center(
                child: Text(
                  message,
                  style: kNormalTextStyle().copyWith(color: kRedColor),
                ),
              ),
      ].animate(
          delay: kAnimationDurationMs(500),
          interval: kAnimationDurationMs(50),
          effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
        ),
    );
  }
}
