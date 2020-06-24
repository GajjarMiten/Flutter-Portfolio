import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptf/provider/emailDataProvider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'sendButton.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  double size = 0.4;

  @override
  Widget build(BuildContext context) {
    final emailData = Provider.of<EmailData>(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          size = 0.4;
        } else if (sizingInformation.isTablet) {
          size = 0.5;
        } else if (sizingInformation.isMobile) {
          size = 0.8;
        }

        return Form(
          onWillPop: () {
            return Future.value(true);
          },
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * size,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onSaved: (newValue) {
                          emailData.name = newValue;
                           FocusScope.of(context).unfocus();
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return "How can I address you?🤔";
                          else
                            return null;
                        },
                        style: TextStyle(
                          color: Color(0xff898989),
                        ),
                        showCursor: true,
                        cursorColor: Color(0xff898989),
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          labelText: "Name",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        onSaved: (newValue) {
                          emailData.email = newValue;
                        },
                        style: TextStyle(
                          color: Color(0xff898989),
                        ),
                        cursorColor: Color(0xff898989),
                        cursorWidth: 3,
                        validator: (value) {
                          final isValidEmail = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (value.isEmpty)
                            return "Email is needed 😬";
                          else if (!isValidEmail)
                            return "Be sure to add valid email!";
                          else
                            return null;
                        },
                        showCursor: true,
                        decoration: InputDecoration(
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    emailData.subject = newValue;
                  },
                  showCursor: true,
                  cursorColor: Color(0xff898989),
                  cursorWidth: 3,
                  style: TextStyle(
                    color: Color(0xff898989),
                  ),
                  decoration: InputDecoration(
                    labelText: "Subject",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    emailData.message = newValue;
                  },
                  maxLines: (sizingInformation.isMobile) ? 3 : 5,
                  style: TextStyle(
                    color: Color(0xff898989),
                  ),
                  showCursor: true,
                  cursorColor: Color(0xff898989),
                  cursorWidth: 3,
                  validator: (value) {
                    if (value.isEmpty)
                      return "What we will talk about? 🤔";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Message",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Send(),
              ],
            ),
          ),
        );
      },
    );
  }
}
