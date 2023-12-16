import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> openLoadingDialog(
    context,
    String text,
    double fontSize,
    Color textColor,
    final Color primaryProgressColor,
    Color secondaryProgressColor) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return LoadingDialog(
          text: text,
          fontSize: fontSize,
          textColor: textColor,
          primaryProgressColor: primaryProgressColor,
          secondaryProgressColor: secondaryProgressColor);
    },
  );
}

class LoadingDialog extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final Color primaryProgressColor;
  final Color secondaryProgressColor;

  const LoadingDialog({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.textColor,
    this.primaryProgressColor = Colors.black,
       this.secondaryProgressColor = Colors.white,
  }) : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Text(
              widget.text,
              textAlign: TextAlign
                  .center, //Incorporar texto para ficar todo junto: Colounm( Expanded)?
              style: TextStyle(
                  fontSize: widget.fontSize,
                  fontFamily: 'lato',
                  fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: CircularProgressIndicator(
            
            backgroundColor: widget.primaryProgressColor,
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation(widget.secondaryProgressColor),
          ),
        ),
      ],
    ),

    );
  }
}
