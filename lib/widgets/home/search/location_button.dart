import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:scial/themes/palette.dart';

class LocationButton extends StatelessWidget {

  const LocationButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      fillColor: Palette.gray900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        children: [
          Icon(
            Icons.my_location_rounded,
            size: 24.0,
            color: Palette.blue500
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Text(
              'use_my_location'.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Palette.gray100,
                height: 1.0
              )
            )
          )
        ]
      )
    );
  }
}