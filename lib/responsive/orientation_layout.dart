import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {

  final Widget portrait;
  final Widget? landscape;

  const OrientationLayout({
    required this.portrait,
    this.landscape
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape && landscape != null ? landscape! : portrait;
  }
}