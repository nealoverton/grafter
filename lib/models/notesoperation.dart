import 'package:flutter/material.dart';
import 'package:grafter/models/Note.dart';

class NotesOperation extends ChangeNotifier {
  final List<Note> _notes = <Note>[];

  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    addNewNote('First Job', 'First Job Description');
  }

  void addNewNote(String title, String description) {
    Note note = Note(title, description);
    _notes.add(note);
    notifyListeners();
  }
}