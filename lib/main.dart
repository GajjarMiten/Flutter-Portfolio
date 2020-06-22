import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptf/helper/CustomTheme.dart';

import 'homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with customTheme {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: customTheme.primaryColor,
        accentColor: customTheme.accentColor,
        scaffoldBackgroundColor: customTheme.sBgColor,
        iconTheme: customTheme.iconTheme,
        appBarTheme: AppBarTheme(
          color: Color(0xff181818),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Miten Gajjar",
      home: HomePage(),
    );
  }
}
