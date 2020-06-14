import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Made with ❤️ "),
              TextSpan(text: "Powerd by "),
            ],
          ),
          style: GoogleFonts.aBeeZee(fontSize: 18),
        ),
        FlutterLogo(),
      ],
    );
  }
}
