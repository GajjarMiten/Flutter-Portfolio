import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/provider/ScrollProvider.dart';


class ContactMe extends StatefulWidget {
  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe>
    with customTheme, SingleTickerProviderStateMixin {
  Gradient gradient = customTheme.gradientWithOutHover;
  Color fontColor = customTheme.fontColorWihtoutHover;

  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
        value: 0.7,
        lowerBound: 0.7);
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollControllerProvider>(context);
    return GestureDetector(
      onTap: () {
        scrollController.getController
            .jumpTo(scrollController.getController.position.maxScrollExtent);
        scrollController.setCurrentIndex(4);
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            gradient = customTheme.gradientOnHover;
            fontColor = Colors.white;
            animationController.forward();
          });
        },
        onExit: (event) {
          setState(() {
            gradient = customTheme.gradientWithOutHover;
            fontColor = Theme.of(context).accentColor;
            animationController.reverse();
          });
        },
        child: ScaleTransition(
          scale: animation,
          child: Container(
            height: 60,
            width: 180,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: gradient,
              border: customTheme.border,
            ),
            child: Text(
              "CONTACT ME",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: fontColor, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
