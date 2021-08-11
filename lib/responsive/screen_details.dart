import 'package:flutter/material.dart';

class ScreenDetails {

  final double? widgetsHeight;
  final Widget widget;
  final bool hasAppBar;

  const ScreenDetails({
    this.widgetsHeight,
    required this.widget,
    this.hasAppBar = false
  });
}