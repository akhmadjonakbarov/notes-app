// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/logic/cubit/notes/notes_cubit.dart';
import 'package:provider/provider.dart';

import '../../../colors/app_colors.dart';
import '../../../data/models/note.dart';
import '../../../providers/notes.dart';
import '../home/widgets/buttons.dart';
import '../screens.dart';

class AddedScreen extends StatefulWidget {
  Note? note;
  AddedScreen({super.key, this.note});

  @override
  State<AddedScreen> createState() => _AddedScreenState();
}

class _AddedScreenState extends State<AddedScreen> {
  final _formKey = GlobalKey<FormState>();

  String title = "";

  String somethings = "";

  void _submit(BuildContext context) async {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      if (widget.note != null) {
        _showEditAlert(context);
      } else {
        _formKey.currentState!.save();
        BlocProvider.of<NotesCubit>(context).addNote(
          title: title,
          somethings: somethings,
        );
        Navigator.of(context).pop();
      }
    }
  }

  void _showEditAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: const Icon(
                  Icons.info,
                  color: Color(0xFF606060),
                  size: 28,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: const BoxDecoration(),
                child: Text(
                  "Save changes?",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: const BoxDecoration(),
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                      ),
                      onPressed: () {
                        bool isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          _formKey.currentState!.save();
                          BlocProvider.of<NotesCubit>(context)
                              .editNote(note: widget.note);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeScreen();
                              },
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF0000),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Discard",
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          Button(
                            icon: Icons.save,
                            onTap: () {
                              _submit(context);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue:
                              widget.note != null ? widget.note!.title : null,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Title...",
                            hintStyle: GoogleFonts.nunito(
                              fontSize: 48,
                              color: AppColors.formTextColor,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          maxLength: null,
                          maxLines: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter title";
                            }
                            return null;
                          },
                          onSaved: (newTitle) {
                            if (widget.note != null) {
                              widget.note!.title = newTitle!;
                            } else {
                              title = newTitle!;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          initialValue: widget.note != null
                              ? widget.note!.somethings
                              : null,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 23),
                          cursorColor: Colors.white,
                          maxLines: null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: "Type something...",
                            hintStyle: GoogleFonts.nunito(
                              fontSize: 23,
                              color: AppColors.formTextColor,
                            ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter somethings";
                            }
                            return null;
                          },
                          onSaved: (newSomethings) {
                            if (widget.note != null) {
                              widget.note!.somethings = newSomethings!;
                            } else {
                              somethings = newSomethings!;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
