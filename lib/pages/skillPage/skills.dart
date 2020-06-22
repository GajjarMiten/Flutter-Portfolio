import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/components/SkillPage/SkillCard.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/helper/particles/particle.dart';
import 'package:ptf/components/AnimatedString/latter.dart';
import 'package:ptf/provider/ScrollProvider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'FlipCard/FlipCard.dart';
import 'SkillChart/Chartcard.dart';

class SkillPage extends StatefulWidget {
  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage>
    with customTheme, TickerProviderStateMixin {
  // opacity Animation
  Animation<double> _animation;
  AnimationController _controller;

// tween Animation
  final Tween<Offset> titleTween =
      Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0));
  AnimationController tweenAnimController;
  Animation<double> tweenAnimation;

  double offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 3500,
        ),
        reverseDuration: Duration(
          seconds: 1,
        ));
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeIn);
    tweenAnimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    tweenAnimation = CurvedAnimation(
        parent: tweenAnimController, curve: Curves.easeOutQuart);
  }

  @override
  void dispose() {
    _controller.dispose();
    tweenAnimController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollControllerProvider>(context);
    final size = MediaQuery.of(context).size;
    scrollController.getController.addListener(() {
      offset = scrollController.getController.offset;
      final maxOffset = scrollController.getController.position.maxScrollExtent;

      if (offset > (maxOffset / 2) - 190 && offset < (maxOffset / 2) + 50) {
        _controller.forward();
        tweenAnimController.forward();
      }
    });
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Particle(size.height, size.width),
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.isDesktop || sizingInformation.isTablet) {
                return FadeTransition(
                  opacity: _animation,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      buildSkillContainer(context, size),
                      Align(
                        alignment: Alignment(0.8, 0.0),
                        child: Container(
                          width: size.width * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 250),
                              SlideTransition(
                                position: tweenAnimation.drive(titleTween),
                                child: buildTitle(),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              buildResponsiveBuilder(size),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 70, bottom: 25, left: 10, right: 10),
                  child: FadeTransition(
                    opacity: _animation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SlideTransition(
                          position: tweenAnimation.drive(titleTween),
                          child: buildTitle(),
                        ),
                        buildSkillContainer(context, size),
                        buildResponsiveBuilder(size),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Word("S"),
        Word("k"),
        Word("i"),
        Word("l"),
        Word("l"),
        Word("s"),
        Word(" "),
      ],
    );
  }

  Widget buildSkillContainer(BuildContext context, Size size) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isMobile) {
          return Container(
            height: size.height * 0.45,
            width: size.width - 10,
            child: FlipCard(
              flipOnHover: true,
              front: SkillCard(),
              back: ChartCard(),
            ),
          );
        } else {
          return Container(
            height: size.height * 0.6,
            width: size.width * 0.45,
            child: FlipCard(
              flipOnHover: true,
              front: SkillCard(),
              back: ChartCard(),
            ),
          );
        }
      },
    );
  }

  ResponsiveBuilder buildResponsiveBuilder(Size size) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double fSize = 17;
        if (sizingInformation.isDesktop || sizingInformation.isTablet) {
          fSize = 18;
        } else {
          fSize = 16;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            mySkills,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Acme",
              color: customTheme.textColor,
              fontSize: fSize,
            ),
          ),
        );
      },
    );
  }

  String mySkills = "The main area of my expertise is "
      "Android application development.\n"
      "I can build small and medium cross-platform application with Flutter and"
      "can desig & build websites and web-apps from scratch using web technologies "
      "like ReactJS and NodeJS. Have proper knowlege of version controll and git.\n"
      "Currently gaining experience by creating and designing application and websites";
}
