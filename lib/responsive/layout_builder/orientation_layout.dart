import 'package:flutter/material.dart';

import 'package:scial/helpers.dart';

class OrientationLayout extends StatelessWidget {

  final double? minSizeForLandscape;
  final Widget portrait;
  final Widget? landscape;

  const OrientationLayout({
    this.minSizeForLandscape,
    required this.portrait,
    this.landscape
  });

  @override
  Widget build(BuildContext context) {
    final bool conditionFulfilled = minSizeForLandscape != null ? MediaQuery.of(context).size.width - getHorizontalPadding(context: context) >= minSizeForLandscape! : true;

    return MediaQuery.of(context).orientation == Orientation.landscape && landscape != null && conditionFulfilled ? landscape! : portrait;
  }
}