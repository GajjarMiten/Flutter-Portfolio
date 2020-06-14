import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/pages/AboutPage/about.dart';
import 'package:ptf/pages/EntryPage/EntryPage.dart';
import 'package:ptf/pages/skillPage/skills.dart';
import 'package:ptf/provider/ScrollProvider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  EdgeInsetsGeometry padding = EdgeInsets.only(left: 65);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scrollController = Provider.of<ScrollControllerProvider>(context);
    if (size.width < 950) {
      setState(() {
        padding = EdgeInsets.only(top: 65);
      });
    } else {
      padding = EdgeInsets.only(left: 65);
    }
    return Container(
      margin: padding,
      child: SingleChildScrollView(
        controller: scrollController.getController,
        child: Column(
          children: [
            EntryPage(),
            AboutPage(),
            SkillPage(),
            Container(height: size.height, width: size.width),
            Container(height: size.height, width: size.width),
          ],
        ),
      ),
    );
  }
}
