import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class ProfileButton extends StatelessWidget {

  const ProfileButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight - 10.0,
      width: kToolbarHeight - 10.0,
      child: RawMaterialButton(
        onPressed: () {},
        fillColor: Palette.gray900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
      )
    );
  }
}