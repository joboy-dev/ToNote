import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/provider/notes_provider.dart';
import 'package:todoey/provider/user_provider.dart';
import 'package:todoey/screens/main/add_notes_screen.dart';
import 'package:todoey/shared/animations.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/custom_appbar.dart';
import 'package:todoey/shared/loading_screen.dart';
import 'package:todoey/shared/navigator.dart';
import 'package:todoey/shared/widgets/button.dart';
import 'package:todoey/shared/widgets/note_item.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  static const String id = 'notes';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider?>(context)?.user;
    final notes = Provider.of<NoteProvider?>(context)?.notes;

    return user == null
        ? const ErrorLoadingScreen()
        : Scaffold(
            // backgroundColor: kBgColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Body
                    CustomAppBar(
                      textColor: kTextTheme(context).withOpacity(0.7),
                      // appBarColor: kBgColor,
                      dividerColor: kYellowColor,
                      appBarText: ' My Notes',
                      trailing: IconTextButton(
                        text: 'New',
                        fontWeight: FontWeight.bold,
                        icon: FontAwesomeIcons.plus,
                        iconColor: kYellowColor,
                        textColor: kYellowColor,
                        fontSize: 17.sp,
                        gap: 20.r,
                        onPressed: () {
                          navigatorPush(context, const AddNotesScreen());
                        },
                      ),
                    ),

                    // Notes
                    notes == null || notes.isEmpty
                        ? Center(
                            child: Text(
                              'There are no notes available.',
                              style: kGreyNormalTextStyle(context),
                            ),
                          )
                        : Padding(
                            padding: kAppPadding(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.70,
                              child: ListView.builder(
                                itemCount: notes.length,
                                itemBuilder: (context, index) {
                                  // reverse index logic
                                  final reversedIndex =
                                      notes.length - 1 - index;
                                  // get individual notes
                                  final note = notes[reversedIndex];
                                  log('List view backend note id -- ${note.id}');
                                  return NoteItem(
                                    // index id for list position (getting from provider)
                                    indexId: reversedIndex,
                                    
                                    // note id for backend todo id (update in backend)
                                    // noteId: note.id!,
                                    // title: '${note.title}',
                                    // content: '${note.content}',
                                  ).animate(
                                    delay: kAnimationDurationMs(500),
                                    effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
                                  );
                                },
                              ),
                            ),
                          ),
                    SizedBox(height: 60.h),
                  ].animate(
                    delay: kAnimationDurationMs(200),
                    interval: kAnimationDurationMs(50),
                    effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
                  ),
                ),
              ),
            ),
          );
  }
}
