import 'package:flutter/material.dart';

class LightButton extends StatelessWidget {

  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final void Function()? onTap;

  const LightButton({ 
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    required this.color,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: 1.0
        )
      )
    );
  }
}