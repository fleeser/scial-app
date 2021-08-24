import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';

class DefaultButtonLoading extends StatelessWidget {

  const DefaultButtonLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomLoadingIndicator(
      size: 16.0, 
      color: Palette.gray900
    );
  }
}