import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:responsive_builder/responsive_builder.dart';

class Particle extends StatefulWidget {
  final double height;
  final double width;

  Particle(this.height, this.width);

  @override
  _ParticleState createState() => _ParticleState();
}

class _ParticleState extends State<Particle> with TickerProviderStateMixin {
  double x = 0;
  double y = 0;
  double dx;
  double dy;
  double opacity = 1;
  double speedOfparticle = 0.3;
  double randValue = 0;

  Offset pointerOffset = Offset(150, 150);

  int maxParticles = 100;
  double maxSize = 3;

  List<Offset> offsets = [];
  List<bool> direction = [];
  List<double> randomDouble = [];
  List<double> randomSize = [];
  List<double> randomOpacity = [];

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < maxParticles; i++) {
      offsets.add(
        Offset(
          math.Random().nextDouble() * widget.width,
          math.Random().nextDouble() * widget.height,
        ),
      );

      direction.add(
        math.Random().nextBool(),
      );

      randomDouble.add(
        math.Random().nextDouble(),
      );

      randomSize.add(math.Random().nextDouble() * maxSize + 1);
      randomOpacity.add(math.Random().nextDouble());
    }

    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          for (int index = 0; index < offsets.length; index++) {
            if (direction[index]) {
              randValue = -speedOfparticle;
            } else {
              randValue = speedOfparticle;
            }
            dx = offsets[index].dx + (randValue * randomDouble[index]);
            dy = offsets[index].dy + randomDouble[index] * speedOfparticle;
            if (dx > widget.width) {
              dx = dx - widget.width;
            } else if (dx < 0) {
              dx = dx + widget.width;
            }
            if (dy > widget.height) {
              dy = dy - widget.height;
            } else if (dy < 0) {
              dy = dy + widget.height;
            }
            offsets[index] = Offset(dx, dy);

            if (randomOpacity[index] > 0.9) {
              randomOpacity[index] = 0.5;
            } else {
              randomOpacity[index] += 0.002;
            }
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isMobile) {
          controller.stop();
        } else {
          controller.repeat();
        }

        return Container(
          child: MouseRegion(
            onHover: (event) {
              setState(() {
                pointerOffset = event.position;
              });
            },
            child: GestureDetector(
              onPanUpdate: (event) {
                // setState(() {
                //   pointerOffset = event.globalPosition;
                // });
              },
              child: CustomPaint(
                child: Container(),
                painter: MyPainter(
                  offsets,
                  pointerOffset,
                  randomSize,
                  randomOpacity,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyPainter extends CustomPainter {
  Paint circlePen = Paint()
    ..color = Colors.white.withOpacity(0.4)
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 1;

  Paint linePen = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 1.5;

  Paint circleLinePen = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 1;

  double circleLineOpacity = 1;
  double lineOpacity = 1;

  double range = 80;

  Offset pointerOffset;

  List<Offset> list = [];
  List<double> particleSize = [];
  List<double> opacity = [];

  MyPainter(this.list, this.pointerOffset, this.particleSize, this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < list.length; i++) {
      // lineOpacity =
      //     1 - (list[i].distance - this.pointerOffset.distance).abs() / 300;
      // if ((pointerOffset.dx - list[i].dx).abs() < 150 &&
      //     (pointerOffset.dy - list[i].dy).abs() < 150) {
      //   canvas.drawLine(
      //     list[i],
      //     pointerOffset,
      //     linePen..color = Colors.white.withOpacity(lineOpacity),
      //   );
      // }
      // for (int j = 0; j < list.length;j++) {
      //   circleLineOpacity = 0.6 - (list[i].distance - list[j].distance).abs() / 200;
      //   if ((list[i].dx - list[j].dx).abs() < range &&
      //       (list[i].dy - list[j].dy).abs() < range) {
      //     canvas.drawLine(
      //         list[i],
      //         list[j],
      //         circleLinePen
      //           ..color = Colors.white.withOpacity(circleLineOpacity));
      //   }
      // }
      canvas.drawCircle(
        list[i],
        particleSize[i],
        circlePen..color = Colors.white.withOpacity(opacity[i]),
      );
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}
