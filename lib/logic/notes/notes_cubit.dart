import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/note.dart';
import '../../../database/db_helper.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial()) {
    emit(NotesWelcome());
    // if NotesInitial class is empty, we will set NotesWelcome to it.
  }

  void addNote({String? title, String? somethings}) {
    // bo'sh [] ro'yxat qaytarsin agar state.notes-da  null kelsa.
    List<Note> notes = [];
    if (state.notes == null || state.notes!.isEmpty) {
      notes = [];
    } else {
      notes = state.notes!;
    }
    try {
      emit(NotesLoading());
      Note newNote = Note(
        id: UniqueKey().toString(),
        title: title!,
        somethings: somethings!,
      );
      notes.add(newNote);
      emit(NotesLoaded(notes: notes));
      DBHelper.insertData(
        table: "notes",
        data: newNote.toMap(),
      );
    } catch (e) {
      emit(NotesError(errorMessage: e.toString()));
    }
  }

  void editNote({Note? note}) {
    try {
      final notes = state.notes!.map((n) {
        if (n.id == note!.id) {
          return Note(
            id: note.id,
            title: note.title,
            somethings: note.somethings,
          );
        }
        return n;
      }).toList();
      emit(NotesLoading());
      emit(NotesLoaded(notes: notes));
      DBHelper.updateNote(note: note);
    } catch (e) {
      emit(NotesError(errorMessage: e.toString()));
    }
  }

  void deleteNote({String? noteId}) {
    List<Note>? notes = state.notes;
    try {
      notes!.removeWhere((node) => node.id == noteId);
      emit(NotesDelete(notes: notes));
      emit(NotesLoading());
      emit(NotesLoaded(notes: notes));
      DBHelper.deleteNote(noteId: noteId);
    } catch (e) {
      emit(
        NotesError(errorMessage: e.toString()),
      );
    }
  }

  List<Note> searchNotes(String title) {
    return state.notes!
        .where(
          (element) => element.title.toLowerCase().contains(
                title.toLowerCase(),
              ),
        )
        .toList();
  }
}
