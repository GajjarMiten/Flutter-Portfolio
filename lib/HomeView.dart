import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/pages/AboutPage/about.dart';
import 'package:ptf/pages/EntryPage/EntryPage.dart';
import 'package:ptf/pages/contactPage/contactPage.dart';
import 'package:ptf/pages/skillPage/skills.dart';
import 'package:ptf/pages/workpage/workPage.dart';
import 'package:ptf/provider/ScrollProvider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  EdgeInsetsGeometry padding = EdgeInsets.only(left: 65);

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollControllerProvider>(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          padding = EdgeInsets.only(left: 65);
        } else {
          padding = EdgeInsets.only(left: 0);
        }
        
        return Container(
          margin: padding,
        
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: scrollController.getController,
            child: Column(
              children: [
                EntryPage(),
                AboutPage(),
                SkillPage(),
                WorkPage(),
                ContactPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
