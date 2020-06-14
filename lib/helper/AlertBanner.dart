import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future buildShowGeneralDialog(BuildContext context, String response) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "hello",
    context: context,
    transitionDuration: Duration(milliseconds: 1500),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(
        begin: Offset(1, 0.4),
        end: Offset(0.32, 0.4),
      );
      final curve = CurveTween(
        curve: Curves.easeInOutBack,
      );
      return SlideTransition(
        position: animation.drive(curve).drive(tween),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pop(true);
      });
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white,width: 2,),
        ),
        backgroundColor: Colors.transparent,
        elevation: 5,
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Text(
            response,
            style: GoogleFonts.aBeeZee(fontSize: 20),
          ),
        ),
      );
    },
  );
}
