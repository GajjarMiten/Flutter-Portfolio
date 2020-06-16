import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/HomeView.dart';
import 'package:ptf/components/NavigationBar/NavigationBar.dart';
import 'package:ptf/provider/ScrollProvider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ScrollControllerProvider>(
        create: (context) => ScrollControllerProvider(),
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              // x = event.position.dx;
              // y = event.position.dy;
            });
          },
          // onHover: (event) {
          //   setState(() {
          //     x += event.delta.dx;
          //     y += event.delta.dy;
          //   });
          // },
          child: Stack(
            children: [
              HomeView(),
              NavigationBar(),
              // CustomPaint(
              //   painter: MyPainter(x, y),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Paint _paint = Paint();
  double x = 0;
  double y = 0;

  MyPainter(double left, double top) {
    _paint..color = Colors.white.withOpacity(0.3);
    x = left;
    y = top;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(Rect.fromCenter(center: Offset(x, y), width: 40, height: 40),
        0, 60, true, _paint);
    // canvas.drawCircle(Offset(x,y), 40, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
