import 'package:flutter/material.dart';

import 'package:scial/helpers.dart';
import 'package:scial/responsive/layout_builder/screen_information.dart';

class AlternativeLayout extends StatelessWidget {
  
  final ScreenInformation full;
  final ScreenInformation? alternative;
  
  const AlternativeLayout({ 
    Key? key,
    required this.full,
    this.alternative
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool fullFitsOnScreen = fitsOnScreen(context: context, widgetsHeight: full.neededHeight, hasAppBar: full.hasAppBar);

    if (fullFitsOnScreen) return full.screen;
    if (alternative != null) {
      final bool alternativeFitsOnScreen = fitsOnScreen(context: context, widgetsHeight: alternative!.neededHeight, hasAppBar: alternative!.hasAppBar);

      if (alternativeFitsOnScreen) return alternative!.screen;
      return SingleChildScrollView(
        child: Container(
          height: getNeededScrollHeight(context: context, widgetsHeight: alternative!.neededHeight, hasAppBar: alternative!.hasAppBar),
          child: alternative!.screen
        )
      );
    }

    return SingleChildScrollView(
      child: Container(
        height: getNeededScrollHeight(context: context, widgetsHeight: full.neededHeight, hasAppBar: full.hasAppBar),
        child: full.screen
      )
    );
  }
}