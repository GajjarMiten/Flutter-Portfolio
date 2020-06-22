import 'package:flutter/material.dart';


class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Made with ❤️ "),
              TextSpan(text: "Powerd by "),
            ],
          ),
          style: TextStyle(fontSize: 18, fontFamily: "Acme"),
        ),
        FlutterLogo(),
      ],
    );
  }
}
