import 'package:flutter/material.dart';

class MyIconButton extends StatefulWidget {
  final IconData icon;
  final double size;
  final String name;
  final Color color;
  final Color onHoverColor;
  final VoidCallback onTap;
  MyIconButton(
      {@required this.icon,
      @required this.name,
      @required this.color,
      @required this.onHoverColor,
      @required this.onTap,
      this.size});
  @override
  _MyIconButtonState createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: Theme(
          data: Theme.of(context),
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: (isHover)
                ? Text(
                    widget.name,
                    style: TextStyle(
                        color: widget.onHoverColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  )
                : Icon(
                    widget.icon,
                    color: widget.color,
                    size: widget.size,
                  ),
          ),
        ),
      ),
    );
  }
}
