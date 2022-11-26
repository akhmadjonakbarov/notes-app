// ignore_for_file: unused_element, null_check_always_fails

// flutter packages
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

// my packages
import '../../added/added_screen.dart';
import '../widgets/empty.dart';
import '../../../../logic/notes/notes_cubit.dart';
import '../../../../colors/app_colors.dart';
import '../../../../data/models/note.dart';

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

  List cardColors() {
    List<Color> colors = [
      const Color(0xFFFF9E9E),
      const Color(0xFF91F48F),
      const Color(0xFF9EFFFF),
      const Color(0xFFB69CFF),
    ];
    return colors;
  }

  Color randomColor() {
    Random random = Random();
    int randomNumber = random.nextInt(cardColors().length);
    return cardColors()[randomNumber];
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(),
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            if (state is NotesWelcome) {
              return const WelcomePage();
            } else if (state is NotesLoaded) {
              return state.notes != null && state.notes!.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.notes!.length,
                      itemBuilder: (context, index) {
                        Note note = state.notes![index];
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
                                  context
                                      .read<NotesCubit>()
                                      .deleteNote(noteId: note.id);
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
                                color: randomColor(),
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
                    )
                  : const WelcomePage();
            } else if (state is NotesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotesError) {
              return Center(
                child: Text(state.errorMessage.toString()),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
