import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/data/models/note.dart';

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
}
