import 'library/libraries.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
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
                fontWeight: FontWeight.w300,
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
