import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Word extends StatefulWidget {
  final String word;

  Word(
    this.word,
  );
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  Color color = Colors.white;

  double fontsize = 50;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 1000,
        ),
        value: 1,
        lowerBound: 0.5);
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticInOut,
      reverseCurve: Curves.elasticInOut,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          fontsize = 60;
        } else if (sizingInformation.isTablet)
          fontsize = 50;
        else
          fontsize = 32;

        return GestureDetector(
          onTapDown: (t) {
            animationController
              ..reset()
              ..forward();
            setState(() {
              color = Theme.of(context).accentColor;
            });
          },
          onTapUp: (t) {
            setState(() {
              color = Colors.white;
            });
          },
          child: MouseRegion(
            onEnter: (event) {
              animationController
                ..reset()
                ..forward();
              setState(() {
                color = Theme.of(context).accentColor;
              });
            },
            onExit: (event) {
              setState(() {
                color = Colors.white;
              });
            },
            child: ScaleTransition(
              scale: animation,
              child: Text(
                widget.word,
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: fontsize,
                  color: color,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
