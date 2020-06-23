import 'package:flutter/material.dart';



class HoverIconButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color onHoverColor;
  final VoidCallback onTap;
  final double iconSize;

  HoverIconButton({
    @required this.icon,
    @required this.color,
    @required this.onHoverColor,
    this.onTap,
    this.iconSize
  });
  @override
  _HoverIconButtonState createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
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
          child: Icon(
            widget.icon,
            color: (isHover) ? widget.onHoverColor : widget.color,
            size: (widget.iconSize == null)?30:widget.iconSize,
          ),
        ),
      ),
    );
  }
}
