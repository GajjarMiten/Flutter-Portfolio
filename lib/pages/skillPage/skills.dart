import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ptf/components/SkillPage/SkillCard.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/helper/particles/particle.dart';
import 'package:ptf/pages/EntryPage/latter.dart';
import 'package:ptf/provider/ScrollProvider.dart';

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

  // text animation
  Animation<int> textAnim;
  AnimationController textAnimController;
  String visibleString = "";

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

    textAnimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 30 * myAbout.length));
    textAnim = StepTween(begin: 0, end: myAbout.length + 8)
        .animate(textAnimController);
  }

  @override
  void dispose() {
    _controller.dispose();
    tweenAnimController.dispose();
    textAnimController.dispose();
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
        textAnimController.forward();
      }
    });
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      // constraints: BoxConstraints(
      //   minHeight: size.height,
      //   minWidth: size.width,
      // ),
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Particle(size.height, size.width),
          FadeTransition(
            opacity: _animation,
            child: Align(
              alignment: Alignment(1, 0.5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: [
                    SlideTransition(
                      position: tweenAnimation.drive(titleTween),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Word("S"),
                              Word("k"),
                              Word("i"),
                              Word("l"),
                              Word("l"),
                              Word("s"),
                              Word(" "),
                              Word("&"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Word("E"),
                              Word("x"),
                              Word("p"),
                              Word("e"),
                              Word("r"),
                              Word("i"),
                              Word("e"),
                              Word("n"),
                              Word("c"),
                              Word("e"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width * 0.35,
                      child: AnimatedBuilder(
                        animation: textAnimController,
                        builder: (BuildContext context, Widget child) {
                          if (textAnim.value == 0) {
                            visibleString = "";
                          } else if (textAnim.value > myAbout.length) {
                            if ((textAnim.value - myAbout.length) % 2 == 0) {
                              visibleString =
                                  myAbout.substring(0, myAbout.length) + '_';
                            } else {
                              visibleString =
                                  myAbout.substring(0, myAbout.length);
                            }
                          } else {
                            visibleString =
                                myAbout.substring(0, textAnim.value) + '_';
                          }
                          return Text(
                            visibleString,
                            style: GoogleFonts.acme(
                              color: customTheme.textColor,
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.5,
              child: FlipCard(
                flipOnHover: true,
                front: SkillCard(),
                back: ChartCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String myAbout = "The main area of my expertise is "
      "Android application development.\n"
      "I can build small and medium cross-platform application with Flutter\n"
      "I can desig & build websites and web-apps from scratch using web technologies "
      "like ReactJS and NodeJS. Have proper knowlege of version controll and git.\n"
      "Currently gaining experience by creating and designing application and websites";
}
