// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/screens/added/added_screen.dart';
import 'package:provider/provider.dart';

import '../../../colors/app_colors.dart';
import '../../../models/note.dart';
import '../../../providers/notes.dart';
import 'empty.dart';

class ListNotes extends StatelessWidget {
  const ListNotes({
    Key? key,
  }) : super(key: key);

  void _deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titleTextStyle: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 23,
          ),
          backgroundColor: AppColors.backgroundColor,
          title: const Text("Do you want to delete?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {},
                  child: const Text("Yes"),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No"),
                )
              ],
            )
          ],
        );
      },
    );
  }

  void _gotoEditScreen(BuildContext context, Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddedScreen(
            note: note,
          );
        },
      ),
    );
  }

  void _deleteAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(),
        child: FutureBuilder(
          future: Provider.of<Notes>(context, listen: false).getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Consumer<Notes>(
              builder: (context, notes, child) {
                if (notes.notes.isNotEmpty) {
                  return ListView.builder(
                    itemCount: notes.notes.length,
                    itemBuilder: (context, index) {
                      Note note = notes.notes[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const DrawerMotion(),
                          children: [
                            CustomSlidableAction(
                              foregroundColor: Colors.transparent,
                              padding: const EdgeInsets.all(5),
                              backgroundColor: Colors.transparent,
                              onPressed: (context) {
                                Provider.of<Notes>(context, listen: false)
                                    .deleteNote(
                                  noteId: note.id,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                alignment: Alignment.center,
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Theme.of(context).errorColor,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            _gotoEditScreen(
                              context,
                              note,
                            );
                          },
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: double.infinity,
                              maxHeight: 160,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  note.title,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.nunito(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Empty();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
