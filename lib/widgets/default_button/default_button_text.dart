import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class DefaultButtonText extends StatelessWidget {

  final String text;

  const DefaultButtonText({ 
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Palette.white,
        height: 1.0
      )
    );
  }
}