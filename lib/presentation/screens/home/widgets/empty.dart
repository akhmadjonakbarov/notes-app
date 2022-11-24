import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Empty extends StatelessWidget {
  const Empty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Center(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              height: 286,
              child: SvgPicture.asset(
                "assets/svgs/nr.svg",
              ),
            ),
            Text(
              "Create your first note!",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
