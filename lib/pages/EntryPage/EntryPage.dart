import 'package:flutter/material.dart';
import 'package:ptf/components/buttons/ContactMeButton.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/helper/particles/particle.dart';

import '../../components/entryPage/EntryTextPage.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage>
    with customTheme, TickerProviderStateMixin {
  // opacity animtion
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Particle(size.height, size.width),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 65.0),
              child: FadeTransition(
                opacity: _animation,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "import ",
                              style: TextStyle(
                                fontFamily: "Pacifico",
                                fontSize: 20,
                                color: customTheme.colorList.first,
                                wordSpacing: 10,
                              ),
                            ),
                            TextSpan(
                              text: "'package:flutter/MyPortfolio.dart'\n",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Kalam",
                                color: customTheme.colorList.last,
                                wordSpacing: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyText(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ContactMe(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
