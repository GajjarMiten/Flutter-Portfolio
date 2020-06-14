import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../AnimatedString/HoverText.dart';
import '../AnimatedString/latter.dart';

class MyText extends StatefulWidget {
  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  Size size = Size(500, 300);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          size = Size(600, 400);
        } else if (sizingInformation.isTablet) {
          size = Size(500, 350);
        } else if (sizingInformation.isMobile) {
          size = Size(370, 300);
        }
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: SizedBox.fromSize(
              size: size,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Word("H"),
                            Word("i"),
                            Word(","),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Word("I"),
                            Word("'"),
                            Word("m"),
                            Word(" "),
                            Word("M"),
                            Word("i"),
                            Word("t"),
                            Word("e"),
                            Word("n"),
                            Word(","),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Word("F"),
                            Word("l"),
                            Word("u"),
                            Word("t"),
                            Word("t"),
                            Word("e"),
                            Word("r"),
                            Word(" "),
                            Word("d"),
                            Word("e"),
                            Word("v"),
                            Word("e"),
                            Word("l"),
                            Word("o"),
                            Word("p"),
                            Word("e"),
                            Word("r"),
                            Word("."),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HoverText(text: "Android❤️Developer"),
                        HoverText(text: "    |    "),
                        HoverText(text: "Web💻Developer"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
