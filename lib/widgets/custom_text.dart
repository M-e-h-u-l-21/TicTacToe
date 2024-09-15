import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final List<Shadow> shadows;
  final String text;
  final double FontSize;
  const CustomText(
      {super.key,
      required this.shadows,
      required this.text,
      required this.FontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        shadows: shadows,
        fontSize: FontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
