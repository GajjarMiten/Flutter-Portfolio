import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../AnimatedString/HoverText.dart';
import '../AnimatedString/latter.dart';

class MyText extends StatefulWidget {
  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> with SingleTickerProviderStateMixin {
  Size size = Size(500, 300);

  final String line1 = "Hi,";
  final String line2 = "I'm Miten,";
  final String line3 = "Flutter developer,";

  final Tween<Offset> titleTween =
      Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0));
  AnimationController tweenAnimController;
  Animation<double> tweenAnimation;

  @override
  void initState() {
    super.initState();

    tweenAnimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    tweenAnimation = CurvedAnimation(
        parent: tweenAnimController, curve: Curves.easeOutQuart);

    tweenAnimController.forward();
  }

  @override
  void dispose() {
    tweenAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          size = Size(600, 400);
        } else if (sizingInformation.isTablet) {
          size = Size(500, 350);
        } else if (sizingInformation.isMobile) {
          size = Size(350, 300);
        }
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: SizedBox.fromSize(
              size: size,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: SlideTransition(
                  position: tweenAnimation.drive(titleTween),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              line1.length,
                              (index) => Word(
                                line1[index],
                              ),
                            ).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              line2.length,
                              (index) => Word(
                                line2[index],
                              ),
                            ).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              line3.length,
                              (index) => Word(
                                line3[index],
                              ),
                            ).toList(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HoverText(text: "Android❤️Developer"),
                          HoverText(text: "    |    "),
                          HoverText(text: "Web💻Developer"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
