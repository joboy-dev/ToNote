import 'package:flutter/material.dart';
import 'package:todoey/entities/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void setNote(Note noteItem) {
    _notes.add(noteItem);
    notifyListeners();
  }

  void setNotes(List<Note> noteItems) {
    _notes = noteItems;
    notifyListeners();
  }
}
