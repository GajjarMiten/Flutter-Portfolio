import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/components/AnimatedString/latter.dart';
import 'package:ptf/components/workPage/cardHover/HoverCard.dart';
import 'package:ptf/helper/particles/particle.dart';
import 'package:ptf/provider/ScrollProvider.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> with TickerProviderStateMixin {
  final String title = "Animal Adoption App";
  final String description = "Lorem ipsum, or lipsum as it is sometimes";
  final String page = "Projects";

  Axis axis = Axis.horizontal;
  EdgeInsetsGeometry padding = EdgeInsets.all(30);

  final tween = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0));
  AnimationController tweenAnimController;
  Animation<double> tweenAnimation;
  double offset;

  Animation<double> _animation;
  AnimationController _controller;

  bool animateCard = false;

  @override
  void initState() {
    super.initState();
    tweenAnimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    tweenAnimation = CurvedAnimation(
        parent: tweenAnimController, curve: Curves.easeOutQuart);
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
    tweenAnimController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scrollController = Provider.of<ScrollControllerProvider>(context);
    scrollController.getController.addListener(() {
      offset = scrollController.getController.offset;

      final maxOffset = scrollController.getController.position.maxScrollExtent;

      if (offset > (maxOffset * 0.75) - 190 &&
          offset < (maxOffset * 0.75) + 50) {
        tweenAnimController.forward();
        _controller.forward();
        setState(() {
          animateCard = true;
        });
      }
    });
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Particle(size.height, size.width),
          SlideTransition(
            position: tweenAnimation.drive(tween),
            child: FadeTransition(
              opacity: _animation,
              child: Padding(
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
                  children: [
                    HoverCard(
                      image: "assets/cat.png",
                      title: title,
                      description: description,
                      time: 1,
                      animate: animateCard,
                    ),
                    HoverCard(
                      image: "assets/cat.png",
                      title: title,
                      description: description,
                      time: 2,
                      animate: animateCard,
                    ),
                    HoverCard(
                      image: "assets/cat.png",
                      title: title,
                      description: description,
                      time: 3,
                      animate: animateCard,
                    ),
                    HoverCard(
                      image: "assets/cat.png",
                      title: title,
                      description: description,
                      time: 4,
                      animate: animateCard,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
