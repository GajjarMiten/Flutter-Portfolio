import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class Skill {
  final Widget icon;
  final String name;
  final double value;
  final List<Color> gradient;
  Skill({this.icon, this.name, this.gradient, this.value});
}

final Skill flutter = Skill(
  icon: FlutterLogo(colors: createMaterialColor(Color(0xffffffff))),
  name: "Flutter",
  gradient: [
    Color(0xff36D1DC),
    Color(0xff5B86E5),
  ],
);

final Skill nodeJS = Skill(
  icon: Icon(
    FlutterIcons.node_js_faw5d,
    color: Colors.white,
  ),
  name: "NodeJS",
  gradient: [
    Color(0xff56ab2f),
    Color(0xffa8e063),
  ],
);

final Skill html = Skill(
  icon: Icon(FlutterIcons.html5_faw, color: Colors.white),
  name: "HTML",
  gradient: [
    Color(0xffcb2d3e),
    Color(0xffef473a),
  ],
);

final Skill css = Skill(
  icon: Icon(FlutterIcons.css3_faw, color: Colors.white),
  name: "CSS",
  gradient: [
    Color(0xff00d2ff),
    Color(0xff928DAB),
  ],
);

final Skill git = Skill(
  icon: Icon(
    FlutterIcons.git_mco,
    color: Colors.white,
  ),
  name: "Git",
  gradient: [
    Color(0xffFF416C),
    Color(0xffFF4B2B),
  ],
);

final Skill python = Skill(
  icon: Icon(
    FlutterIcons.language_python_mco,
    color: Colors.white,
  ),
  name: "Python",
  gradient: [
    Color(0xff0575E6),
    Colors.yellow,
  ],
);

final Skill firebase = Skill(
  icon: Icon(
    FlutterIcons.firebase_mco,
    color: Colors.white,
  ),
  name: "Firebase",
  gradient: [
    Color(0xfff46b45),
    Color(0xffeea849),
  ],
);

final Skill javaScript = Skill(
  icon: Icon(
    FlutterIcons.language_javascript_mco,
    color: Colors.white,
  ),
  name: "JavaScript",
  gradient: [
    Color(0xffF7971E),
    Color(0xffFFD200),
  ],
);

final Skill typeScript = Skill(
  icon: Icon(
    FlutterIcons.language_typescript_mco,
    color: Colors.white,
  ),
  name: "TypeScript",
  gradient: [
    Color(0xff7474BF),
    Color(0xff348AC7),
  ],
);

final Skill react = Skill(
  icon: Icon(
    FlutterIcons.react_faw5d,
    color: Colors.white,
  ),
  name: "ReactJS",
  gradient: [
    Color(0xff1FA2FF),
    Color(0xff12D8FA),
  ],
);

final Skill sql = Skill(
  icon: Icon(
    FlutterIcons.database_ent,
    color: Colors.white,
  ),
  name: "SQL",
  gradient: [
    Color(0xff4776E6),
    Color(0xff8E54E9),
  ],
);

List<Skill> chartdata = [flutter, firebase, git, nodeJS, python];
List<Skill> allSkill = [
  flutter,
  firebase,
  react,
  git,
  html,
  css,
  javaScript,
  python,
  nodeJS,
  sql
];
List<Skill> skillsetA = [flutter, firebase, python, git];
List<Skill> skillsetB = [html, css, javaScript];
List<Skill> skillsetC = [react, nodeJS, sql];
