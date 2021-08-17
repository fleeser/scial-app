import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:scial/routes.dart';

import 'package:scial/themes/palette.dart';

class ChooseImageActionModal extends StatelessWidget {

  final VoidCallback? onChangePressed;
  final VoidCallback? onRemovePressed;
  
  const ChooseImageActionModal({ 
    Key? key,
    this.onChangePressed,
    this.onRemovePressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.gray900,
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 52.0,
            width: MediaQuery.of(context).size.width - 24.0 - 24.0,
            child: RawMaterialButton(
              onPressed: () {
                Routes.navigateBack();
                
                if (onChangePressed != null) onChangePressed!();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'change'.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Palette.gray100,
                  height: 1.0
                )
              )
            )
          ),
          SizedBox(
            height: 52.0,
            width: MediaQuery.of(context).size.width - 24.0 - 24.0,
            child: RawMaterialButton(
              onPressed: () {
                Routes.navigateBack();
                
                if (onRemovePressed != null) onRemovePressed!();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0))),
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'remove'.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Palette.gray100,
                  height: 1.0
                )
              )
            )
          )
        ]
      )
    );
  }
}