// ignore_for_file: unused_element

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_app/screens/added/added_screen.dart';

import 'empty.dart';
import 'library/libraries.dart';

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
                              onPressed: (context) {},
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
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            padding: const EdgeInsets.all(25),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                            ),
                            child: Text(
                              note.somethings,
                              style: GoogleFonts.nunito(
                                fontSize: 25,
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
