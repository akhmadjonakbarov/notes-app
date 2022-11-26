// ignore_for_file: must_be_immutable

part of 'notes_cubit.dart';

@immutable
abstract class NotesState {
  // this is abstract class for State
  List<Note>? notes;
  NotesState({this.notes});
}

class NotesWelcome extends NotesState {
  // this is Notes Welcome class. If we don't have anything, we will return these.
}

class NotesInitial extends NotesState {
  // this class for initialing notes.
}

class NotesLoading extends NotesState {
  // this class for loading notes. If we add new notes, we will
}

class NotesLoaded extends NotesState {
  // this class for reloading data.
  List<Note>? notes;
  NotesLoaded({required this.notes}) : super(notes: notes);
}

class NoteAdded extends NotesState {
  // this class for additing new notes.
  final Note note;
  NoteAdded(this.note);
}

class NotesDelete extends NotesState {
  // this class for deleting.
  List<Note>? notes;
  NotesDelete({this.notes}) : super(notes: notes);
}

class NotesError extends NotesState {
  final String? errorMessage;
  NotesError({this.errorMessage});
}
