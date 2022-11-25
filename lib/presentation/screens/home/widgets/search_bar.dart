import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/note.dart';
import '../../../../logic/cubit/notes/notes_cubit.dart';
import '../../added/added_screen.dart';

class SearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          query = '';
        },
        child: Text(
          "Clear",
          style: GoogleFonts.nunito(),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final notes = BlocProvider.of<NotesCubit>(context).searchNotes(query);
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        Note note = notes[index];
        return Text(note.title);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      final notes = BlocProvider.of<NotesCubit>(context).searchNotes(query);
      if (notes.isEmpty) {
        return const Text("Bunday note mavjud emas!");
      }
      return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          Note note = notes[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddedScreen(
                      note: note,
                    );
                  },
                ),
              );
            },
            title: Text(note.title),
          );
        },
      );
    }
    return Container();
  }
}
