import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/note.dart';
import '../../../database/db_helper.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial()) {
    emit(NotesWelcome());
  }

  void addNote({String? title, String? somethings}) {
    List<Note>? notes = state.notes;
    try {
      Note newNote = Note(
        id: UniqueKey().toString(),
        title: title!,
        somethings: somethings!,
      );
      notes!.add(newNote);

      emit(NotesLoading(notes: notes));
      emit(NoteAdded(newNote));
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
      emit(NotesLoading(notes: notes));
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
      emit(NotesLoading(notes: notes));
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
