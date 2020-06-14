import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'desktop/NavbarDesktop.dart';
import 'mobile/NavBarMobile.dart';
import 'tablet/NavbarTablet.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: NavBarWeb(),
      mobile: NavBarMob(),
      tablet: NavBarTab(),
    );
  }
}
