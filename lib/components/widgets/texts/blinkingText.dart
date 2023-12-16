import 'package:flutter/material.dart';

class BlinkText extends StatefulWidget {
  final String text;
  final bool hasIcon;
  final Icon? icon;
  final double fontSize;
  final Color color;
  final int blinkDuration;
  const BlinkText(
      {Key? key, required this.text, required this.hasIcon, this.icon, required this.fontSize,required this.color, this.blinkDuration = 1})
      : super(key: key);

  @override
  _BlinkTextState createState() => _BlinkTextState();
}

class _BlinkTextState extends State<BlinkText>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: widget.blinkDuration));
    _animationController!.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.hasIcon
        ? FadeTransition(
            opacity: _animationController!,
            child: Wrap(
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.color,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.fontSize),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: widget.icon,
                )
              ],
            ),
          )
        : FadeTransition(
            opacity: _animationController!,
            child: Wrap(
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.color,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.fontSize),
                ),
              ],
            ),
          ));
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
