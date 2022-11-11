import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/list_notes.dart';
import 'added/added_screen.dart';
import '../colors/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
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
          decoration: const BoxDecoration(),
          child: Column(
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
                            onTap: () {},
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Button(
                            icon: Icons.info_outline,
                            onTap: () {},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListNotes(),
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

class Button extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const Button({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.widgetsBackColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        splashRadius: 16,
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
