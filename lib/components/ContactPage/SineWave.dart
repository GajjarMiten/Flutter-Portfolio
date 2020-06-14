import 'dart:math';

import 'package:ptf/helper/CustomTheme.dart';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SineWave extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;
  SineWave(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color});

  @override
  State<StatefulWidget> createState() {
    return _SineWaveState();
  }
}

class _SineWaveState extends State<SineWave>
    with customTheme, TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animationController.addListener(
      () {
        animList1.clear();
        for (int i = -2 - widget.xOffset;
            i <= widget.size.width.toInt() + 2;
            i++) {
          animList1.add(Offset(
              i.toDouble() + widget.xOffset,
              sin((animationController.value * 360 - i) %
                          360 *
                          Vector.degrees2Radians) *
                      20 +
                  50 +
                  widget.yOffset));
        }
      },
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) => ClipPath(
        child: Container(
          width: widget.size.width,
          height: widget.size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: customTheme.colorList,
            ),
          ),
        ),
        clipper: WaveClipper(animationController.value, animList1),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
