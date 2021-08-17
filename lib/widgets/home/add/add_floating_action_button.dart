import 'package:flutter/material.dart';

import 'package:scial/modals/add_model.dart';
import 'package:scial/themes/palette.dart';

class AddFloatingActionButton extends StatelessWidget {

  const AddFloatingActionButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight - 10.0,
      width: kToolbarHeight - 10.0,
      child: RawMaterialButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Palette.gray900,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
            builder: (BuildContext context) {
              return AddModal();
            }
          );
        },
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