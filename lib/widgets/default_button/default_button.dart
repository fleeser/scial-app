import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/default_button/default_button_loading.dart';
import 'package:scial/widgets/default_button/default_button_text.dart';

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
        onPressed: _onPressed,
        enableFeedback: !isLoading,
        fillColor: isLoading ? Palette.gray400 : Palette.blue600,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: isLoading ? DefaultButtonLoading() : DefaultButtonText(text: text)
      )
    );
  }

  void _onPressed() {
    if (!isLoading && onPressed != null) onPressed!();
  }
}