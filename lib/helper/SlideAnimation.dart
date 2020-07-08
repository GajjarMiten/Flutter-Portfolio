import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/provider/ScrollProvider.dart';

class SlideAnimatedWidget extends StatefulWidget {
  final Widget widget;
  final double fraction;
  final Offset begin;
  final Offset end;
  final double waitTime;
  SlideAnimatedWidget({
    @required this.widget,
    @required this.fraction,
    @required this.begin,
    @required this.end,
    this.waitTime,
  });

  @override
  _SlideAnimatedWidgetState createState() => _SlideAnimatedWidgetState();
}

class _SlideAnimatedWidgetState extends State<SlideAnimatedWidget>
    with SingleTickerProviderStateMixin {
  Tween<Offset> tween;
  Animation animation;
  AnimationController controller;
  double waitTime;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutQuart);
    tween = Tween<Offset>(begin: widget.begin, end: widget.end);
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
    return SlideTransition(
      position: animation.drive(tween),
      child: widget.widget,
    );
  }
}
