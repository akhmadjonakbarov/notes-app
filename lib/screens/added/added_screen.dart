// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/models/note.dart';
import '../../colors/app_colors.dart';
import '../../providers/notes.dart';
import '../home_screen.dart';
import 'package:provider/provider.dart';

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
  Note? _note;

  void _submit(BuildContext context) async {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      Provider.of<Notes>(context, listen: false)
          .addNote(title: title, somethings: somethings);
      Navigator.of(context).pop();
    }
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
            horizontal: 24,
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue:
                          widget.note != null ? widget.note!.title : null,
                      style: const TextStyle(color: Colors.white, fontSize: 48),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        hintText: "Title...",
                        hintStyle: GoogleFonts.nunito(
                          fontSize: 48,
                          color: AppColors.formTextColor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter title";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        title = newValue!;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      initialValue:
                          widget.note != null ? widget.note!.somethings : null,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      maxLines: 6,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Type something...",
                        hintStyle: GoogleFonts.nunito(
                          fontSize: 16,
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
                      onSaved: (newValue) {
                        somethings = newValue!;
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
