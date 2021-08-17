import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class CustomDropdownListItem extends StatelessWidget {

  final bool isLastItem;
  final int index;
  final String item;
  final VoidCallback itemPressed;

  const CustomDropdownListItem({ 
    Key? key,
    required this.isLastItem,
    required this.index,
    required this.item,
    required this.itemPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.0,
      child: RawMaterialButton(
        onPressed: itemPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(isLastItem ? 12.0 : 0.0))),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            item,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.0,
              color: Palette.gray100,
              height: 1.0
            )
          )
        )
      )
    );
  }
}