import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TextFormInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?) validator;
  final Color? color;
  final bool? filled;
  final num widthByTotal;
  final EdgeInsets? contentPadding;
  final double fontSize;
  final String placeholder;
  final double placeholderSize;
  final double? errorMarginSize;
  final double? errorMarginTop;
  final double? errorTextSize;

  const TextFormInput({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.emailAddress,
    this.isPassword = false,
    required this.validator,
    this.color = Colors.white,
    this.filled = true,
    required this.widthByTotal,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 15.0,
    ),
    this.fontSize = 13,
    required this.placeholder,
    this.placeholderSize = 13,
    this.errorMarginSize = 4,
    this.errorMarginTop = 0.5,
    this.errorTextSize = 10,
    
  }) : super(key: key);

  @override
  State<TextFormInput> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  bool _hiddenText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * widget.widthByTotal),
      child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          obscureText: widget.isPassword ? _hiddenText : widget.isPassword,
          validator: (value) => widget.validator(value),
          cursorColor: Colors.black,
          style: TextStyle(fontSize: widget.fontSize),
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _hiddenText ? PhosphorIcons.eyeSlash : PhosphorIcons.eye,
                      color: Colors.black,
                      size: 18,
                    ),
                    onPressed: () => setState(() =>  _hiddenText = !_hiddenText),
                  )
                : Icon(null),
            helperText: " ",
            helperStyle: TextStyle(fontSize: widget.errorMarginSize),
            errorStyle: TextStyle(
                fontSize: widget.errorTextSize, height: widget.errorMarginTop),
            contentPadding: widget.contentPadding,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: widget.placeholder,
            hintStyle: TextStyle(fontSize: widget.placeholderSize, fontFamily: 'lato'),
            fillColor: widget.color,
            filled: widget.filled,
          )),
    );
  }
}
