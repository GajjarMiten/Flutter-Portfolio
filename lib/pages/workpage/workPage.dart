import 'package:flutter/material.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width
    );
  }
}