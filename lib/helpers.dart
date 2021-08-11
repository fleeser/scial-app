import 'dart:ui' as ui;

import 'package:flutter/material.dart';

bool fitsOnScreen(BuildContext context, double widgetsHeight, { bool hasAppBar = false }) => MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - (hasAppBar ? kToolbarHeight + MediaQuery.of(context).padding.top : 0.0) - widgetsHeight >= 0.0;

double getMaxWidth(BuildContext context) {
  double padding = MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right + 48.0;
  
  return MediaQuery.of(context).size.width <= 640.0 ? MediaQuery.of(context).size.width - padding : 640.0 - padding;
}

double getTextHeight(String text, TextStyle textStyle, double maxWidth) {
  TextPainter textPainter = TextPainter()
    ..text = TextSpan(text: text, style: textStyle)
    ..textDirection = ui.TextDirection.ltr
    ..layout(minWidth: 0.0, maxWidth: maxWidth);

  return textPainter.height;
}

// TODO: Something is not right here:

double getNeededScrollHeight(BuildContext context, { required double widgetsHeight, bool hasAppBar = false }) => MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom + (hasAppBar ? kToolbarHeight : 0.0) + widgetsHeight;