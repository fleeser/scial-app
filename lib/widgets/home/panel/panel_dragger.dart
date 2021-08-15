import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class PanelDragger extends StatelessWidget {

  const PanelDragger({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 6.0,
      decoration: BoxDecoration(
        color: Palette.gray100,
        borderRadius: BorderRadius.circular(3.0)
      )
    );
  }
}