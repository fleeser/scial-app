import 'package:flutter/material.dart';

import 'package:scial/helpers.dart';

class MaxWidthWidget extends StatelessWidget {

  final Widget child;

  const MaxWidthWidget({ 
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: getMaxWidth(context)),
      child: child
    );
  }
}