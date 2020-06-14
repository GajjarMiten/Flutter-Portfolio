import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool flipOnHover;

  FlipCard({this.front, this.back, this.flipOnHover});

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  bool isFront = true;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.ease);

    controller.addListener(() {
      setState(() {});
      if (animation.value > 0.5)
        isFront = false;
      else
        isFront = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        if (widget.flipOnHover) {
          controller.forward();
        }
      },
      onExit: (event) {
        if (widget.flipOnHover) {
          controller.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value * math.pi),
            child: child,
          );
        },
        child: (isFront)
            ? widget.front
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: widget.back,
              ),
      ),
    );
  }
}
