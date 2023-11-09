import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final List<Shadow> shadow;
  final double fontSize;
  const CustomText(
      {super.key,
      required this.text,
      required this.shadow,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          shadows: shadow, fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}
