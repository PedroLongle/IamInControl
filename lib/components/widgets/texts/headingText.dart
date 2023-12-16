import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.titleSize = 26,
      this.subTitleSize = 14.5,
      required this.color,
      required this.isTitleBold})
      : super(key: key);

  final String title;
  final String subtitle;
  final Color color;
  final bool isTitleBold;
  final double titleSize;
  final double subTitleSize;

  @override
  Widget build(BuildContext context) {
    return isTitleBold
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('$title',
                            style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                                color: color)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('$subtitle',
                          style: TextStyle(fontSize: subTitleSize, color: color)),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Text('$title',
                        style: TextStyle(fontSize: 14.5, color: color)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('$subtitle',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: color)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
