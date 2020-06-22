import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/helper/AlertBanner.dart';
import 'package:ptf/helper/CustomTheme.dart';
import 'package:ptf/provider/emailDataProvider.dart';

class Send extends StatefulWidget {
  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> with customTheme {
  Gradient gradient = customTheme.gradientWithOutHover;

  Color fontColor = customTheme.fontColorWihtoutHover;

  @override
  Widget build(BuildContext context) {
    final emailData = Provider.of<EmailData>(context);
    final form = Form.of(context);
    return GestureDetector(
      onTap: () {
        if (form.validate()) {
          form.save();
          Firestore.instance.collection("messages").document().setData(
            {
              "name": emailData.name,
              "email": emailData.email,
              "subject": emailData.subject,
              "message": emailData.message,
              "time": DateTime.now(),
            },
          );

          buildShowGeneralDialog(context, "Message sent!😄");
        }
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            gradient = customTheme.gradientOnHover;
            fontColor = Colors.white;
          });
        },
        onExit: (event) {
          setState(() {
            gradient = customTheme.gradientWithOutHover;
            fontColor = Theme.of(context).accentColor;
          });
        },
        child: Container(
          height: 50,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: gradient,
            border: customTheme.border,
          ),
          child: Text(
            "SEND",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: fontColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
