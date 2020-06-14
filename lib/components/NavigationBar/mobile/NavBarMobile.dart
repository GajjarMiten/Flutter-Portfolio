import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:ptf/components/buttons/MyIconButton.dart';
import 'package:ptf/provider/ScrollProvider.dart';

class NavBarMob extends StatefulWidget {
  @override
  _NavBarMobState createState() => _NavBarMobState();
}

class _NavBarMobState extends State<NavBarMob> {
  int currentIndex = 0;

  final duration = Duration(milliseconds: 1500);
  final curve = Curves.easeInQuart;

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollControllerProvider>(context);
    final maxOffset = (scrollController.getController.position.maxScrollExtent);
    // final double maxOffset = 0;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65,
      color: Theme.of(context).appBarTheme.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              MyIconButton(
                icon: FlutterIcons.home_ant,
                name: "HOME",
                color: (scrollController.getCurrentIndex == 0)
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
                onTap: () {
                  scrollController.getController.animateTo(maxOffset * 0,
                      duration: duration, curve: curve);
                  scrollController.setCurrentIndex(0);
                },
              ),
              SizedBox(
                height: 10,
              ),
              MyIconButton(
                icon: EvilIcons.user,
                name: "ABOUT",
                color: (scrollController.getCurrentIndex == 1)
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
                onTap: () {
                  scrollController.getController.animateTo(maxOffset * 0.25,
                      duration: duration, curve: curve);
                  scrollController.setCurrentIndex(1);
                },
              ),
              SizedBox(
                height: 10,
              ),
              MyIconButton(
                icon: EvilIcons.gear,
                name: "SKILLS",
                color: (scrollController.getCurrentIndex == 2)
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
                onTap: () {
                  scrollController.getController.animateTo(maxOffset * 0.5,
                      duration: duration, curve: curve);
                  scrollController.setCurrentIndex(2);
                },
              ),
              SizedBox(
                height: 10,
              ),
              MyIconButton(
                icon: EvilIcons.trophy,
                name: "WORK",
                color: (scrollController.getCurrentIndex == 3)
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
                onTap: () {
                  scrollController.getController.animateTo(maxOffset * 0.75,
                      duration: duration, curve: curve);
                  scrollController.setCurrentIndex(3);
                },
              ),
              SizedBox(
                height: 10,
              ),
              MyIconButton(
                icon: EvilIcons.envelope,
                name: "CONTACT",
                color: (scrollController.getCurrentIndex == 4)
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
                onTap: () {
                  scrollController.getController
                      .animateTo(maxOffset, duration: duration, curve: curve);
                  scrollController.setCurrentIndex(4);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
