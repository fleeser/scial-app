import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator extends StatelessWidget {

  final double size;
  final Color color;

  const CustomLoadingIndicator({ 
    required this.size,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: size,
      color: color
    );
  }
}