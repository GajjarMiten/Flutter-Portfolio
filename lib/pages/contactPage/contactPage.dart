import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ptf/components/AnimatedString/latter.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/helper/particles/particle.dart';
import 'package:ptf/provider/ScrollProvider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../components/ContactPage/footer.dart';
import '../../provider/emailDataProvider.dart';

import '../../components/ContactPage/CosWave.dart';
import '../../components/ContactPage/SineWave.dart';
import '../../components/ContactPage/contactForm.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with customTheme, TickerProviderStateMixin {
  // tween aniamtion
  final tween = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0));
  AnimationController tweenAnimController;
  Animation<double> tweenAnimation;

  AnimationController tweenAnimController2;
  Animation<double> tweenAnimation2;

  Animation<double> _animation;
  AnimationController _controller;

  double offset;

  @override
  void initState() {
    super.initState();
    tweenAnimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    tweenAnimation = CurvedAnimation(
        parent: tweenAnimController, curve: Curves.easeOutQuart);

    tweenAnimController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    tweenAnimation2 = CurvedAnimation(
        parent: tweenAnimController2, curve: Curves.easeOutQuart);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
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
    tweenAnimController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scrollController = Provider.of<ScrollControllerProvider>(context);

    scrollController.getController.addListener(() {
      offset = scrollController.getController.offset;

      final maxOffset = scrollController.getController.position.maxScrollExtent;

      if (offset >= maxOffset) {
        _controller.forward();
        tweenAnimController.forward();
        tweenAnimController2.forward();
      }
    });

    return Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Particle(size.height, size.width),
          Align(
            alignment: Alignment.bottomCenter,
            child: SineWave(
              size: Size(size.width, 130),
              xOffset: 0,
              yOffset: 0,
              color: Colors.red,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: 0.9,
              child: CosWave(
                size: Size(size.width, 130),
                xOffset: 45,
                yOffset: -5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: tweenAnimation.drive(tween),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Word("C"),
                          Word("o"),
                          Word("n"),
                          Word("t"),
                          Word("a"),
                          Word("c"),
                          Word("t"),
                          Word(" "),
                          Word("m"),
                          Word("e"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ResponsiveBuilder(
                      builder: (context, sizingInformation) {
                        double fSize = 18;
                        if (sizingInformation.isDesktop ||
                            sizingInformation.isTablet) {
                          fSize = 18;
                        } else if (sizingInformation.isMobile) {
                          fSize = 15;
                        }
                        return SlideTransition(
                          position: tweenAnimation2.drive(tween),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: info1),
                                  TextSpan(
                                    text: email,
                                    style: GoogleFonts.acme(
                                      color: customTheme.accentColor,
                                    ),
                                  ),
                                  TextSpan(text: info2),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.acme(
                                color: customTheme.textColor,
                                fontSize: fSize,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ChangeNotifierProvider<EmailData>(
                      create: (context) => EmailData(),
                      child: ContactForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Footer(),
            ),
          ),
        ],
      ),
    );
  }

  final String info1 = "Wanna get in touch or talk about a project ? "
      " Feel free to contact me via email at ";
  final String email = "iammg26@gmail.com ";
  final String info2 = "or drop a line in the form!";
}
