import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ptf/components/buttons/ContactMeButton.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/helper/particles/particle.dart';

import '../../components/entryPage/EntryTextPage.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> with customTheme {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.toString());
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Particle(size.height, size.width),
          Align(
            alignment: Alignment(0, -0.9),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "import ",
                    style: GoogleFonts.pacifico(
                      fontSize: 20,
                      color: customTheme.colorList.first,
                      wordSpacing: 10,
                    ),
                  ),
                  TextSpan(
                    text: "'package:flutter/MyPortfolio.dart'\n",
                    style: GoogleFonts.kalam(
                      fontSize: 20,
                      color: customTheme.colorList.last,
                      wordSpacing: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.3),
            child: MyText(),
          ),
          Align(
            alignment: Alignment(0, 0.6),
            child: ContactMe(),
          ),
        ],
      ),
    );
  }
}
