// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import './widgets/search_bar.dart';

import '../../../colors/app_colors.dart';
import '../screens.dart';
import 'widgets/buttons.dart';
import 'widgets/list_notes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    void info(BuildContext context) {
      // about application
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bu dastur kerakli ma'lumotlarni qayd qilib borish uchun sizga yordam beradi.",
                  strutStyle: const StrutStyle(),
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
                )
              ],
            ),
          );
        },
      );
    }

    void openSearchBar(BuildContext context) {
      showSearch(
        context: context,
        delegate: SearchBar(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notes",
                      style: GoogleFonts.nunito(
                        fontSize: 43,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          Button(
                            icon: Icons.search,
                            onTap: () {
                              openSearchBar(context);
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Button(
                            icon: Icons.info_outline,
                            onTap: () {
                              info(context);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const ListNotes(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: AppColors.backgroundColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddedScreen();
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 45,
        ),
      ),
    );
  }
}
