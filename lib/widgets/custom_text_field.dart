import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? obscurePressed;
  final bool isPasswordField;
  final TextInputType textInputType;
  final IconData icon;
  final bool obscureText;
  final BorderRadiusGeometry? borderRadius;
  final Function(String)? onChanged;

  const CustomTextField({ 
    this.controller,
    this.isPasswordField = false,
    required this.hintText,
    this.obscurePressed,
    this.textInputType = TextInputType.text,
    required this.icon,
    this.obscureText = false,
    this.borderRadius,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Palette.gray800,
        borderRadius: borderRadius == null ? BorderRadius.circular(12.0) : borderRadius
      ),
      child: Row(children: textFieldChildren(icon: icon, isPasswordField: isPasswordField, controller: controller, hintText: hintText, textInputType: textInputType, obscureText: obscureText, obscurePressed: obscurePressed, onChanged: onChanged))
    );
  }
}

List<Widget> textFieldChildren({ required IconData icon, required bool isPasswordField, TextEditingController? controller, required String hintText, required TextInputType textInputType, required bool obscureText, VoidCallback? obscurePressed, Function(String)? onChanged }) {
  List<Widget> list = <Widget>[
    Icon(
      icon,
      size: 24.0,
      color: Palette.gray400
    ),
    SizedBox(width: 24.0),
    Expanded(
      child: Container(
        height: 52.0,
        child: TextField(
          onChanged: (String text) => onChanged != null ? onChanged(text) : null,
          autocorrect: false,
          autofocus: false,
          obscureText: obscureText,
          keyboardType: textInputType,
          keyboardAppearance: Brightness.dark,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 16.0,
              height: 1.0,
              color: Palette.gray400
            )
          ),
          style: TextStyle(
            fontSize: 16.0,
            height: 1.0,
            color: Palette.gray100
          )
        )
      )
    )
  ];

  if (isPasswordField) list.addAll(<Widget>[
    SizedBox(width: 24.0),
    SizedBox(
      width: 36.0,
      height: 36.0,
      child: RawMaterialButton(
        onPressed: obscurePressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        child: Icon(
          obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          color: obscureText ? Palette.gray400 : Palette.blue500,
          size: 24.0
        )
      )
    )
  ]);

  return list;
}