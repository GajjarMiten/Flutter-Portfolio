import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;
  HoverText({@required this.text});
  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 700),
        value: 0.5,
        lowerBound: 0.5);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _controller..forward();
        setState(() {
          _color = Theme.of(context).accentColor;
        });
      },
      onExit: (event) {
        _controller.reverse();
        setState(() {
          _color = Colors.white;
        });
      },
      child: ScaleTransition(
        scale: _animation,
        child: Text(
          widget.text,
          style: TextStyle(
            color: _color,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
