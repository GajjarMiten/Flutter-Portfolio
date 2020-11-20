import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:ptf/components/buttons/HoverIconButton.dart';
import 'package:ptf/components/buttons/MyIconButton.dart';
import 'package:ptf/provider/ScrollProvider.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class NavBarWeb extends StatefulWidget {
  @override
  _NavBarWebState createState() => _NavBarWebState();
}

class _NavBarWebState extends State<NavBarWeb> {
  int currentIndex = 0;

  final duration = Duration(milliseconds: 1500);
  final curve = Curves.easeInQuart;

  @override
  Widget build(BuildContext context) {
    final scrollController = Provider.of<ScrollControllerProvider>(context);
    final maxOffset = (scrollController.getController.position.maxScrollExtent);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 65,
      color: Theme.of(context).appBarTheme.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Image.asset("assets/prf.png", scale: 0.5)),
          ),
          Column(
            children: [
              MyIconButton(
                icon: AntDesign.home,
                name: "HOME",
                size: 26,
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
          Column(
            children: [
              HoverIconButton(
                onTap: () {
                  urlLauncher.launch('https://github.com/GajjarMiten');
                },
                icon: EvilIcons.sc_github,
                color: Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
              ),
              HoverIconButton(
                onTap: () {
                  urlLauncher.launch('https://twitter.com/GajjarMiten');
                },
                icon: EvilIcons.sc_twitter,
                color: Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
              ),
              HoverIconButton(
                onTap: () {
                  urlLauncher.launch(
                      'https://www.linkedin.com/in/miten-gajjar-58270316a');
                },
                icon: EvilIcons.sc_linkedin,
                color: Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
              ),
              HoverIconButton(
                onTap: () {
                  urlLauncher.launch('https://t.me/mit_26');
                },
                icon: EvilIcons.sc_telegram,
                color: Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
              ),
              HoverIconButton(
                onTap: () {
                  urlLauncher.launch('https://www.instagram.com/_.mi10._/');
                },
                icon: FlutterIcons.instagram_ant,
                iconSize: 22,
                color: Theme.of(context).iconTheme.color,
                onHoverColor: Theme.of(context).accentColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
