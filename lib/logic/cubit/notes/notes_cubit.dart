import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/note.dart';

import '../../../database/db_helper.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit()
      : super(
          NotesInitial(
            notes: [
              Note(
                id: UniqueKey().toString(),
                title: "Kitob o'qish",
                somethings: "Vatan haqida kitob o'qish",
              ),
              Note(
                id: UniqueKey().toString(),
                title: "Bozorga borish",
                somethings: "Bozordan kiyim va boshqa narsalar olish",
              ),
            ],
          ),
        );

  void addNote({String? title, String? somethings}) {
    try {
      Note newNote = Note(
        id: UniqueKey().toString(),
        title: title!,
        somethings: somethings!,
      );
      List<Note> notes = state.notes!;
      notes.add(newNote);

      emit(NotesLoading(notes: notes));
      DBHelper.insertData(
        table: "notes",
        data: newNote.toMap(),
      );
    } catch (e) {
      emit(NotesError(errorMessage: e.toString()));
    }
  }

  void editNote({Note? note}) {
    List<Note> notes = [];

    try {
      final index =
          state.notes!.indexWhere((element) => element.id == note!.id);
      notes[index] = note!;
      emit(NotesInitial(notes: notes));
      DBHelper.updateNote(note: note);
    } catch (e) {
      emit(NotesError(errorMessage: e.toString()));
    }
  }
}
