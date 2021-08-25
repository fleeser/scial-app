import 'dart:ui' as ui;

import 'package:flutter/material.dart';

double getVerticalPadding({ required BuildContext context }) {
  final Orientation orientation = MediaQuery.of(context).orientation;
  return 48.0 + (orientation == Orientation.portrait ? MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom : MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right);
}

double getHorizontalPadding({ required BuildContext context }) {
  final Orientation orientation = MediaQuery.of(context).orientation;
  return  48.0 + (orientation == Orientation.portrait ? MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right : MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom);
}

double getMaxWidth({ required BuildContext context }) {
  return MediaQuery.of(context).size.width <= 640.0 ? MediaQuery.of(context).size.width - getHorizontalPadding(context: context) : 640.0 - getHorizontalPadding(context: context);
}

double getTextHeight({ required String text, required TextStyle textStyle, required double maxWidth }) {
  TextPainter textPainter = TextPainter()
    ..text = TextSpan(text: text, style: textStyle)
    ..textDirection = ui.TextDirection.ltr
    ..layout(minWidth: 0.0, maxWidth: maxWidth);

  return textPainter.height;
}

bool fitsOnScreen({ required BuildContext context, required double widgetsHeight, required bool hasAppBar }) {
  return MediaQuery.of(context).size.height - getVerticalPadding(context: context) - (hasAppBar ? kToolbarHeight : 0.0) - widgetsHeight >= 0.0;
}

// TODO: Something is not right here:

double getNeededScrollHeight({ required BuildContext context, required double widgetsHeight, required bool hasAppBar }) {
  final double overflowingSize = (MediaQuery.of(context).size.height - getVerticalPadding(context: context) - (hasAppBar ? kToolbarHeight : 0.0) - widgetsHeight).abs();
  return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - (hasAppBar ? kToolbarHeight : 0.0) + overflowingSize;
}



//MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom + (hasAppBar ? kToolbarHeight : 0.0) + widgetsHeight;