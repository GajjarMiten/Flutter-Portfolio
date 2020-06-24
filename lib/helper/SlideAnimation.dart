import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/provider/ScrollProvider.dart';

class SlideAnimatedWidget extends StatefulWidget {
  final Widget widget;
  final double fraction;
  SlideAnimatedWidget({
    @required this.widget,
    @required this.fraction,
  });

  @override
  _SlideAnimatedWidgetState createState() => _SlideAnimatedWidgetState();
}

class _SlideAnimatedWidgetState extends State<SlideAnimatedWidget>
    with TickerProviderStateMixin {
  final Tween<Offset> tween =
      Tween<Offset>(begin: Offset(0, 0.3), end: Offset(0, 0));
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutQuart);
    controller.forward();
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
        controller.forward();
      }
    });
    return SlideTransition(
      position: animation.drive(tween),
      child: FadeTransition(opacity: animation, child: widget.widget),
    );
  }
}
