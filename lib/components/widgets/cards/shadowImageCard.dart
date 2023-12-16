import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class ShadowImageCard extends StatelessWidget {
  const ShadowImageCard({
    Key? key,
    required this.onTap,
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.height,
    required this.width,
    required this.imageAsset,
    this.contentPadding = const EdgeInsets.only(left: 8, top: 12),
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final double fontSize;
  final Color textColor;
  final double height;
  final double width;
  final String imageAsset;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TransparentImageCard(
        width: width,
        height: height,
        imageProvider: AssetImage(imageAsset),
        contentPadding: contentPadding,
        title: Column(
          children: [
            Text(text,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize)),
          ],
        ),
      ),
    );
  }
}
