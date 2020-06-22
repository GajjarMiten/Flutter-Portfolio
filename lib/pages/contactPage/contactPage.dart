import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:provider/provider.dart';
import 'package:ptf/components/AnimatedString/latter.dart';
import 'package:ptf/components/buttons/HoverIconButton.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/helper/particles/particle.dart';
import 'package:ptf/provider/ScrollProvider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

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
        vsync: this, duration: Duration(milliseconds: 2000));
    tweenAnimation = CurvedAnimation(
        parent: tweenAnimController, curve: Curves.easeOutQuart);

    tweenAnimController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2300));
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
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double fSize = 18;
        if (sizingInformation.isDesktop || sizingInformation.isTablet) {
          fSize = 18;
        } else if (sizingInformation.isMobile) {
          fSize = 15;
        }

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
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
                                  Word("M"),
                                  Word("e"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SlideTransition(
                              position: tweenAnimation2.drive(tween),
                              child: Container(
                                width: size.width * 0.4,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: info1),
                                      TextSpan(
                                        text: email,
                                        style: TextStyle(
                                          fontFamily: "Acme",
                                          color: customTheme.accentColor,
                                        ),
                                      ),
                                      TextSpan(text: info2),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Acme",
                                    color: customTheme.textColor,
                                    fontSize: fSize,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ChangeNotifierProvider<EmailData>(
                              create: (context) => EmailData(),
                              child: ContactForm(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
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
                (sizingInformation.isMobile)
                    ? buildContactRow(context)
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildContactRow(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color color = Colors.white.withOpacity(0.5);
    return Positioned(
      left: size.width*0.25,
      bottom: 80,
      child: Container(
        width: size.width / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HoverIconButton(
              onTap: () {
                urlLauncher.launch('https://twitter.com/GajjarMiten');
              },
              icon: EvilIcons.sc_twitter,
              color: color,
              onHoverColor: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 15,
            ),
            HoverIconButton(
              onTap: () {
                urlLauncher.launch('https://www.linkedin.com/in/mitengajjar');
              },
              icon: EvilIcons.sc_linkedin,
              color: color,
              onHoverColor: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 15,
            ),
            HoverIconButton(
              onTap: () {
                urlLauncher.launch('https://t.me/mit_26');
              },
              icon: EvilIcons.sc_telegram,
              color: color,
              onHoverColor: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 30,
            ),
            HoverIconButton(
              onTap: () {
                urlLauncher.launch('https://www.instagram.com/_.mi10._/');
              },
              icon: FlutterIcons.instagram_ant,
              iconSize: 22,
              color: color,
              onHoverColor: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 30,
            ),
            HoverIconButton(
              onTap: () {
                urlLauncher.launch('https://github.com/GajjarMiten');
              },
              icon: EvilIcons.sc_github,
              color: color,
              onHoverColor: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }

  final String info1 = "Have any question or want to talk with me ? "
      " you can easily connect with me via email at ";
  final String email = "iammg26@gmail.com ";
  final String info2 = "or feel free to drop a message in the form!😃";
}
