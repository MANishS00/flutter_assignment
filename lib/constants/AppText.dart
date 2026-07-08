import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;

  const AppText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style ?? TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
