import 'package:flutter/material.dart';

class IsLoading extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final Color primaryProgressColor;
  final Color secondaryProgressColor;
  const IsLoading({
    super.key,
    required this.text,
    required this.fontSize,
    this.textColor = Colors.black,
    this.primaryProgressColor = Colors.black,
    this.secondaryProgressColor = Colors.white,
  });

  @override
  State<IsLoading> createState() => _IsLoadingState();
}

class _IsLoadingState extends State<IsLoading> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 280.0),
          child: Text(
            widget.text,
            textAlign: TextAlign
                .center, //Incorporar texto para ficar todo junto: Colounm( Expanded)?
            style: TextStyle(
                fontSize: widget.fontSize,
                fontFamily: 'lato',
                fontWeight: FontWeight.bold),
          ),
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
    ));
  }
}
