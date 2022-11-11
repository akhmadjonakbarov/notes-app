import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/db_helper.dart';

import '../models/note.dart';

class Notes with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes {
    return [..._notes];
  }

  void addNote({String? title, String? somethings}) {
    Note newNote = Note(
      id: UniqueKey().toString(),
      title: title!,
      somethings: somethings!,
    );
    _notes.add(newNote);
    notifyListeners();

    DBHelper.insertData(
      table: "notes",
      data: {
        "id": newNote.id,
        "title": newNote.title,
        "somethings": newNote.somethings,
      },
    );
  }

  void updateNote() {}

  Future<void> getNotes() async {
    List<Note> notes = await DBHelper.getData(tableName: DBHelper.tableName);
    if (notes.isNotEmpty) {
      _notes = notes;
    }
    notifyListeners();
  }
}
