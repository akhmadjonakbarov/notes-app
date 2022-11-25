// ignore_for_file: must_be_immutable

part of 'notes_cubit.dart';

@immutable
abstract class NotesState {
  List<Note>? notes;
  NotesState({this.notes});
}

class NotesWelcome extends NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  List<Note>? notes;
  NotesLoaded({required this.notes}) : super(notes: notes);
}

class NoteAdded extends NotesState {
  final Note note;
  NoteAdded(this.note);
}

class NotesDelete extends NotesState {
  List<Note>? notes;
  NotesDelete({this.notes}) : super(notes: notes);
}

class NotesError extends NotesState {
  final String? errorMessage;
  NotesError({this.errorMessage});
}
