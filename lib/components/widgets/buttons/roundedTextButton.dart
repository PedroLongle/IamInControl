import 'package:flutter/material.dart';

class RoundedTextButton extends StatelessWidget {
  const RoundedTextButton(
      {Key? key,
      required this.onTap,
      required this.isLoading,
      required this.text,
      this.icon,
      this.iconPadding,
      required this.fontSize,
      required this.height,
      required this.width,
      required this.color,
      required this.textColor,
      required this.textWeight,
      required this.textAlignment,
      required this.textPadding,
      this.hasShadow = false,
      required this.borderRadius,
      required this.borderColor,
      required this.borderWidth,
      })
      : super(key: key);

  final VoidCallback onTap;
  final bool isLoading;
  final String text;
  final Icon? icon;
  final EdgeInsets? iconPadding;
  final double fontSize;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final FontWeight textWeight;
  final TextAlign textAlignment;
  final EdgeInsets textPadding;
  final bool? hasShadow;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            width: width,
            height: height,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      hasShadow == null
                          ?BoxShadow()
                          : BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                    ],
                    color: color,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: borderColor, width: borderWidth)),
                child:
                    Row(children: [Center(child: CircularProgressIndicator())]),
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                       hasShadow != false
                          ? BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          : BoxShadow()
                    ],
                    color: color,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: borderColor, width: borderWidth)),
                child: Row(children: [
                  icon != null
                      ? Wrap(children: [
                          iconPadding != null
                              ? Padding(
                                  padding: iconPadding!,
                                  child: icon,
                                )
                              : Padding(
                                  padding: EdgeInsets.all(0),
                                  child: icon,
                                ),
                          Padding(
                            padding: textPadding,
                            child: Text(text,
                                textAlign: textAlignment,
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                )),
                          ),
                        ])
                      : Padding(
                          padding: textPadding,
                          child: Text(text,
                              textAlign: textAlignment,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'lato',
                                fontWeight: textWeight,
                                fontSize: fontSize,
                              )),
                        )
                ]),
              ),
            ),
          );
  }
}
