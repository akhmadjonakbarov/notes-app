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

class NotesLoading extends NotesState {}

class NotesError extends NotesState {
  final String? errorMessage;
  NotesError({this.errorMessage});
}
