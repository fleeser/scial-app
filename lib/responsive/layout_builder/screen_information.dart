import 'package:flutter/material.dart';

class ScreenInformation {
  final Widget screen;
  final bool hasAppBar;
  final double neededHeight;

  const ScreenInformation({
    required this.screen,
    this.hasAppBar = false,
    required this.neededHeight
  });
}