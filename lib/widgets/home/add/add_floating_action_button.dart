import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class AddFloatingActionButton extends StatelessWidget {

  const AddFloatingActionButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight - 10.0,
      width: kToolbarHeight - 10.0,
      child: RawMaterialButton(
        onPressed: () {},
        fillColor: Palette.blue500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: Icon(
          Icons.add_rounded,
          color: Palette.white,
          size: kToolbarHeight - 30.0
        )
      )
    );
  }
}