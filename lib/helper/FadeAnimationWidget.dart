import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/provider/ScrollProvider.dart';

class FadeAnimatedWidget extends StatefulWidget {
  final Widget widget;
  final double fraction;
  final double waitTime;
  FadeAnimatedWidget({
    @required this.widget,
    @required this.fraction,
    this.waitTime,
  });

  @override
  _FadeAnimatedWidgetState createState() => _FadeAnimatedWidgetState();
}

class _FadeAnimatedWidgetState extends State<FadeAnimatedWidget>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  double waitTime;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInQuad);
    waitTime = (widget.waitTime) ?? 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollControllerProvider>(context);

    scrollController.getController.addListener(() {
      double offset = scrollController.getController.offset;

      final maxOffset = scrollController.getController.position.maxScrollExtent;

      if (offset > (maxOffset / widget.fraction) - 190 &&
          offset < (maxOffset / widget.fraction) + 50) {
        Future.delayed(
          Duration(milliseconds: 200 * waitTime.toInt()),
          () {
            controller.forward();
          },
        );
      }
    });
    return FadeTransition(
      opacity: animation,
      child: widget.widget,
    );
  }
}
