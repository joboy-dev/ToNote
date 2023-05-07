// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoey/screens/main/dialog_screens/edit_todo.dart';
import 'package:todoey/shared/constants.dart';
import 'package:todoey/shared/widgets/snackbar.dart';

import 'dialog.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    super.key,
    required this.title,
    required this.isChecked,
    required this.date,
    required this.onChanged,
  });

  final String title;
  final bool isChecked;
  final DateTime date;
  Function(bool? value) onChanged;

  List colors = [
    kGreenColor.withOpacity(0.35),
    kDarkYellowColor.withOpacity(0.35),
    Color.fromARGB(255, 142, 184, 255),
    Color.fromARGB(255, 250, 255, 184),
    Color.fromARGB(255, 255, 184, 184),
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          value: isChecked,
          onChanged: isChecked ? (value) {} : onChanged),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              isChecked
                  ? showSnackbar(
                      context, 'You cannot edit a completed todo item')
                  : showDialogBox(context: context, screen: EditTodoScreen());
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      subtitle: Text(
        'Expires ${date.toString().substring(0, 10)}',
        style: kGreyNormalTextStyle.copyWith(fontSize: 12.0),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      contentPadding: EdgeInsets.all(5.0),
    );
  }
}
