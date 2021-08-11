import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';

class DefaultButton extends StatelessWidget {

  final String text;
  final void Function()? onPressed;
  final bool isLoading;

  const DefaultButton({ 
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.0,
      width: double.infinity,
      child: RawMaterialButton(
        onPressed: isLoading ? null : onPressed,
        fillColor: Palette.blue600,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: isLoading ? CustomLoadingIndicator(
          color: Palette.white,
          size: 16.0
        ) : Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Palette.white,
            height: 1.0
          )
        )
      )
    );
  }
}