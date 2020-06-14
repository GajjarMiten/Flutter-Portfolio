import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SkillButton extends StatefulWidget {
  final Widget icon;
  final String name;
  final List<Color> gradient;

  SkillButton({this.icon, this.name, this.gradient})
      : assert(
          icon != null,
          name != null,
        ),
        assert(
          gradient != null,
        );

  @override
  _SkillButtonState createState() => _SkillButtonState();
}

class _SkillButtonState extends State<SkillButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  double height = 50;
  double width = 120;
  double fontSize = 20;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000),
        lowerBound: 0.2,
        reverseDuration: Duration(milliseconds: 1700));

    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );

    Future.delayed(
        Duration(milliseconds: (Random().nextDouble() * 2000).toInt()), () {
      _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          height = 50;
          width = 120;
        } else if (sizingInformation.isTablet) {
          height = 40;
          width = 100;
        } else {
          height = 40;
          width = 100;
          fontSize = 11;
        }

        return FadeTransition(
          opacity: animation,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Colors.black45,
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: widget.gradient),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                widget.icon,
              ],
            ),
          ),
        );
      },
    );
  }
}
