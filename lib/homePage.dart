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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ScrollControllerProvider>(
        create: (context) => ScrollControllerProvider(),
        child: Stack(
          children: [
            NavigationBar(),
            HomeView(),
          ],
        ),
      ),
    );
  }
}
