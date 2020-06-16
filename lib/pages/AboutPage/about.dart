import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/helper/particles/particle.dart';
import 'package:ptf/components/AnimatedString/latter.dart';
import 'package:ptf/provider/ScrollProvider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with TickerProviderStateMixin, customTheme {
  // title text animation
  final Tween<Offset> titleTween =
      Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0));

  // opacity animtion
  Animation<double> _animation;
  AnimationController _controller;

  // profile animation
  final Tween<Offset> tween =
      Tween<Offset>(begin: Offset(1, 0.2), end: Offset(0, 0.2));

  AnimationController tweenAnimController;
  Animation<double> tweenAnimation;
  // text animation
  Animation<int> textAnim;
  AnimationController textAnimController;
  String visibleString = "";

  double offset;

  double fSize = 18;
  Size profileSize = Size(350, 350);

  Alignment textAlignment = Alignment.bottomLeft;
  Alignment profileAlignment = Alignment.topRight;
  TextAlign textAlign = TextAlign.start;

  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  double width = 0.5;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    tweenAnimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    tweenAnimation = CurvedAnimation(
        parent: tweenAnimController, curve: Curves.easeOutQuart);

    _animation = CurvedAnimation(
        parent: _controller, curve: Curves.easeIn, reverseCurve: Curves.easeIn);

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

  void switchToDesktopTablet() {
    fSize = 18;
    textAlignment = Alignment.bottomLeft;
    profileAlignment = Alignment(0.8, -0.35);
    textAlign = TextAlign.start;
    mainAxisAlignment = MainAxisAlignment.start;
    width = 0.45;
    profileSize = Size(350, 350);
  }

  void switchToMobile() {
    fSize = 16;
    textAlignment = Alignment.center;
    textAlign = TextAlign.center;
    profileAlignment = Alignment(0, 0.6);
    mainAxisAlignment = MainAxisAlignment.center;
    width = 0.65;
    profileSize = Size(250, 250);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scrollController = Provider.of<ScrollControllerProvider>(context);

    scrollController.getController.addListener(() {
      offset = scrollController.getController.offset;

      final maxOffset = scrollController.getController.position.maxScrollExtent;

      if (offset > (maxOffset / 4) - 190 && offset < (maxOffset / 4) + 50) {
        _controller.forward();

        tweenAnimController.forward();
        textAnimController.forward();
      }
    });
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop || sizingInformation.isTablet) {
          switchToDesktopTablet();
        } else {
          switchToMobile();
        }
        return Container(
          padding: const EdgeInsets.only(left: 30),
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Particle(size.height, size.width),
              Align(
                alignment: textAlignment,
                child: FadeTransition(
                  opacity: _animation,
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height * 0.7,
                    width: size.width * width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideTransition(
                          position: tweenAnimation.drive(titleTween),
                          child: Row(
                            mainAxisAlignment: mainAxisAlignment,
                            children: [
                              Word("A"),
                              Word("b"),
                              Word("o"),
                              Word("u"),
                              Word("t"),
                              Word(" "),
                              Word("M"),
                              Word("e"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        AnimatedBuilder(
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
                              textAlign: textAlign,
                              style: TextStyle(
                                fontFamily: "Acme",
                                color: customTheme.textColor,
                                fontSize: fSize,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: profileAlignment,
                child: SlideTransition(
                  position: tweenAnimation.drive(tween),
                  child: myProfile(profileSize),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String myAbout = "Hey!! I am Miten Gajjar. "
      " A 20years old Software Engineer powered by VS Code and coffee. "
      " I am new to community so"
      " I prefer to keep learning, continue challenging myself,"
      " and do interesting things that matter.\n"
      "I am passionate about building excellent "
      "software that improves the lives of those around me.";

  Widget myProfile(Size size) => Container(
        width: size.height,
        height: size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            alignment: Alignment.centerRight,
            fit: BoxFit.contain,
            image: Image.asset(
              "assets/me.png",
              scale: 1,
            ).image,
          ),
        ),
      );
}
