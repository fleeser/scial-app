import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/home/panel/panel_dragger.dart';

class CollapsedPanel extends StatelessWidget {

  const CollapsedPanel({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.gray900,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))
      ),
      child: Column(
        children: [
          SizedBox(height: 24.0),
          PanelDragger(),
          Padding(
            padding: EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
            child: Text(
              '${'panel_drag_up'.tr()}!   🎉',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Palette.gray100,
                height: 1.6
              )
            )
          )
        ]
      )
    );
  }
}