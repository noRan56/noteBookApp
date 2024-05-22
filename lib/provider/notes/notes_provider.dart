import 'package:flutter/material.dart';
import 'package:task/DB/DB.dart';
import 'package:task/models/node.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];
  NotesProvider() {
    getNotes();
  }
  Future<void> getNotes() async {
    notes = await DB().getNotes();
    notifyListeners();
  }

  Future<void> insert({required Note note}) async {
    await DB().insertNote(note: note);
    await getNotes();
  }

  Future<void> update({required Note note}) async {
    await DB().updateNote(note: note);
    await getNotes();
  }

  Future<bool> delete({required Note note}) async {
    await DB().deleteNote(note: note);
    await getNotes();
    return true;
  }
}
