import 'package:flutter/material.dart';

import 'package:scial/helpers.dart';
import 'package:scial/responsive/screen_details.dart';

class ResponsiveLayout extends StatelessWidget {

  final ScreenDetails scroll;
  final ScreenDetails? alternative;
  final ScreenDetails? full;

  const ResponsiveLayout({
    required this.scroll,
    this.alternative,
    this.full
  });

  @override
  Widget build(BuildContext context) {
    if (full != null) {
      if (fitsOnScreen(context, full!.widgetsHeight!, hasAppBar: full!.hasAppBar)) {
        return full!.widget;
      }
    }

    if (alternative != null) {
      if (fitsOnScreen(context, alternative!.widgetsHeight!, hasAppBar: alternative!.hasAppBar)) {
        return alternative!.widget;
      }
    }

    return scroll.widget;
  }
}