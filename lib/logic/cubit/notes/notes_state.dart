part of 'notes_cubit.dart';

@immutable
abstract class NotesState {
  List<Note>? notes = [];
  NotesState({this.notes});
}

class NotesInitial extends NotesState {
  List<Note>? notes = [];
  NotesInitial({this.notes}) : super(notes: notes);
}

class NoteAdded extends NotesState {
  List<Note>? notes = [];
  NoteAdded({this.notes}) : super(notes: notes);
}

class NotesLoading extends NotesState {
  List<Note>? notes = [];
  NotesLoading({this.notes}) : super(notes: notes);
}

class NotesError extends NotesState {
  final String? errorMessage;
  NotesError({this.errorMessage});
}
