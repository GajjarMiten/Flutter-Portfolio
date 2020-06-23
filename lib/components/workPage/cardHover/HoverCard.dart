import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptf/components/buttons/HoverIconButton.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import 'gradient.dart';

class HoverCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final int time;
  final bool animate;
  final String githubURL;

  HoverCard({
    @required this.image,
    @required this.title,
    @required this.description,
    @required this.time,
    @required this.animate,
    @required this.githubURL,
  });
  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with customTheme, TickerProviderStateMixin {
  double height = 300;
  double cHeight = 300;
  double width = 400;
  double cWidth = 400;
  double titleFontSize = 35;
  double descriptionFontSize = 18;
  double sizeBoxHeight = 0;
  bool tabMobToDesk = false;
  double imagePadding = 0;
  double desPaddingLeft = 75;
  double desPaddingRight = 30;

  final color = (gradient..shuffle()).first;

  Alignment alignment = Alignment.center;
  MainAxisAlignment axisAlignment = MainAxisAlignment.start;

  final Duration duration = Duration(milliseconds: 700);
  final Curve curve = Curves.easeInQuad;

  void switchToMobileScreen() {
    height = 250;
    width = 300;
    cHeight = 425;
    cWidth = 300;
    alignment = Alignment.topCenter;
    axisAlignment = MainAxisAlignment.end;
    descriptionFontSize = 16;
    titleFontSize = 25;
    sizeBoxHeight = 270;
    tabMobToDesk = true;
    imagePadding = 25.0;
    desPaddingLeft = 15;
    desPaddingRight = 35;
  }

  void switchToTabletScreen() {
    height = 130;
    width = 130;
    cHeight = 300;
    cWidth = 400;
    axisAlignment = MainAxisAlignment.end;
    alignment = Alignment.centerLeft;
    titleFontSize = 35;
    descriptionFontSize = 18;
    tabMobToDesk = true;
    sizeBoxHeight = 0;
    imagePadding = 0;
    desPaddingLeft = 75;
    desPaddingRight = 30;
  }

  void switchToDeskropScreen() {
    height = 300;
    width = 400;
    cHeight = 300;
    cWidth = 400;
    alignment = Alignment.center;
    titleFontSize = 35;
    descriptionFontSize = 18;
    sizeBoxHeight = 0;
    tabMobToDesk = false;
    imagePadding = 0;
    desPaddingLeft = 80;
  }

  // profile animation
  final Tween<Offset> tween =
      Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0));

  AnimationController tweenAnimController;
  Animation<double> tweenAnimation;

  // opacity animtion
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    tweenAnimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    tweenAnimation = CurvedAnimation(
        parent: tweenAnimController, curve: Curves.easeOutQuart);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    tweenAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      Future.delayed(
        Duration(milliseconds: 200 * widget.time),
        () {
          tweenAnimController.forward();
          _controller.forward();
        },
      );
    }

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (tabMobToDesk && sizingInformation.isDesktop) {
          switchToDeskropScreen();
        }
        if (sizingInformation.isTablet) {
          switchToTabletScreen();
        } else if (sizingInformation.isMobile) {
          switchToMobileScreen();
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: tweenAnimation.drive(tween),
              child: AnimatedContainer(
                curve: curve,
                duration: duration,
                alignment: Alignment.center,
                height: cHeight + 50,
                width: cWidth + 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    MouseRegion(
                      onEnter: (event) {
                        if (sizingInformation.isDesktop) {
                          setState(() {
                            alignment = Alignment.centerLeft;
                            height = 130;
                            width = 130;
                          });
                        }
                      },
                      onExit: (event) {
                        if (sizingInformation.isDesktop) {
                          setState(() {
                            alignment = Alignment.center;
                            height = 300;
                            width = 400;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        curve: curve,
                        duration: duration,
                        height: cHeight + 10,
                        width: cWidth + 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: color,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      curve: curve,
                      duration: duration,
                      height: cHeight,
                      width: cWidth,
                      decoration: BoxDecoration(
                        color: customTheme.sBgColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: FadeTransition(
                        opacity: _animation,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                curve: curve,
                                duration: duration,
                                height: sizeBoxHeight,
                              ),
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontFamily: "pacifico",
                                  fontSize: titleFontSize,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: desPaddingLeft,
                                  right: desPaddingRight,
                                  bottom: 10,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    widget.description,
                                    style: TextStyle(
                                      fontFamily: "Acme",
                                      fontSize: descriptionFontSize,
                                      color: customTheme.colorList.last,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 75,
                          bottom: 30,
                        ),
                        child: HoverIconButton(
                          icon: FlutterIcons.github_alt_faw,
                          color: Colors.white60,
                          onHoverColor: customTheme.accentColor,
                          onTap: () => urlLauncher.launch(widget.githubURL),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: imagePadding),
                      child: AnimatedAlign(
                        alignment: alignment,
                        curve: curve,
                        duration: duration,
                        child: AnimatedContainer(
                          curve: curve,
                          duration: duration,
                          height: height,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(widget.image).image,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
