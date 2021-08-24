import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class CustomPasswordField extends StatelessWidget {

  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final void Function() obscurePasswordPressed;
  final bool obscurePassword;

  const CustomPasswordField({ 
    Key? key,
    required this.icon,
    required this.controller,
    required this.hintText,
    required this.obscurePasswordPressed,
    required this.obscurePassword
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Palette.gray800,
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: Row(
        children: [
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
                obscureText: obscurePassword,
                autocorrect: false,
                autofocus: false,
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
          ),
          SizedBox(width: 24.0),
          SizedBox(
            width: 36.0,
            height: 36.0,
            child: RawMaterialButton(
              onPressed: obscurePasswordPressed,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
              child: Icon(
                obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                color: obscurePassword ? Palette.gray400 : Palette.blue500,
                size: 24.0
              )
            )
          )
        ]
      )
    );
  }
}

// obscurePasswordPressed doesnt work