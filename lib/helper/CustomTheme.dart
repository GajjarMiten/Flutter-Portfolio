import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin customTheme {
  static final List<Color> colorList = [
    Color(0xffA770EF),
    Color(0xffCF8BF3),
    Color(0xffFDB99B),
  ];

  static final Gradient gradientWithOutHover = LinearGradient(
    colors: [
      Colors.transparent,
      Colors.transparent,
    ],
  );

  static final Gradient gradientOnHover = LinearGradient(
    colors: colorList,
  );

  static final double width = 2;
  static final Border border = Border.all(color: Colors.white70);

  static final BorderRadius borderRadius = BorderRadius.circular(12);

  static final Color fontColorWihtoutHover = Color(0xffA770EF);

  static final Color fontColorOnHover = Colors.white;

  static final Color primaryColor = Color(0xff252627);
  static final Color accentColor = Color(0xffA770EF);
  static final Color sBgColor = Color(0xff252627);

  static final IconThemeData iconTheme = IconThemeData(
    color: Color(0xff838383),
    size: 35,
  );

  static final Color textColor = Color(0xffFDB99B);
}
