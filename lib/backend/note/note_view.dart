import 'dart:developer';

import 'package:todoey/backend/note/note_api.dart';
import 'package:todoey/backend/user/user_view.dart';
import 'package:todoey/entities/note.dart';
import 'package:todoey/entities/user.dart';

class NoteView {
  final _userView = UserView();
  final _noteAPI = NoteAPI();

  /// Function to add new todo
  addNote({required NoteModel note}) async {
    // get user details so as to retrieve user id for current logged in user
    var userData = await _userView.getUserDetails();

    if (userData is User) {
      // create map of json data
      Map<String, dynamic> jsonData = {
        "title": note.title,
        "content": note.content,
        "author": userData.id,
      };

      // store data gotten from response in todo api
      var data = await _noteAPI.addNote(data: jsonData);

      if (data is Map<String, dynamic>) {
        final noteData = Note.fromJson(data);
        log('(NoteView) New note added -- ${noteData.title}');
        return noteData;
      } else {
        return data;
      }
    }
  }

  /// Function to get all user todos
  getUserNotes() async {
    var jsonData = await _noteAPI.getNotes();

    if (jsonData is List) {
      // convert jsondata into a Note model
      final notes = jsonData.map((data) => Note.fromJson(data)).toList();

      log('Getting user notes text -- ${notes.first}');
      return notes;
    }
  }

  /// Function to update user note
  updateNote({required NoteModel note, required int id}) async {
    // get user details so as to retrieve user id for current logged in user
    var userData = await _userView.getUserDetails();

    if (userData is User) {
      // create map of json data
     Map<String, dynamic> jsonData = {
        "title": note.title,
        "content": note.content,
        "author": userData.id,
      };
      var data = await _noteAPI.updateNote(jsonData, id);

      if (data is Map<String, dynamic>) {
        final noteData = Note.fromJson(data);

        return noteData;
      } else {
        return data;
      }
    }
  }

  /// Function to delete user note
  deleteNote({required int id}) async {
    // get user details so as to retrieve user id for current logged in user
    var userData = await _userView.getUserDetails();

    if (userData is User) {
      var data = await _noteAPI.deleteNote(id);
      return data;
    }
  }
}
