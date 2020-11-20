import 'package:flutter/material.dart';
import 'package:ptf/components/AnimatedString/latter.dart';
import 'package:ptf/components/workPage/cardHover/HoverCard.dart';
import 'package:ptf/helper/FadeAnimationWidget.dart';
import 'package:ptf/helper/SlideAnimation.dart';
import 'package:ptf/helper/particles/particle.dart';

import 'works.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final String page = "Projects";
  final double fraction = 4 / 3;

  Axis axis = Axis.horizontal;
  EdgeInsetsGeometry padding = EdgeInsets.all(30);

  double offset;

  bool animateCard = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Particle(size.height, size.width),
          SlideAnimatedWidget(
            begin: Offset(0, 0.5),
            end: Offset(0, 0),
            fraction: fraction,
            widget: FadeAnimatedWidget(
              fraction: fraction,
              widget: Padding(
                padding: const EdgeInsets.only(top: 65.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    page.length,
                    (index) => Word(
                      page[index],
                    ),
                  ).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 128.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(
                    projectList.length,
                    (index) => HoverCard(
                      image: projectList[index].image,
                      title: projectList[index].title,
                      description: projectList[index].description,
                      time: index + 1,
                      animate: animateCard,
                      githubURL: projectList[index].githubURL,
                      webURL: projectList[index].webURL ?? "",
                    ),
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
