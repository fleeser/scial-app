import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class CustomTextField extends StatelessWidget {

  final IconData icon;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String hintText;
  
  const CustomTextField({ 
    Key? key,
    required this.icon,
    this.textInputType = TextInputType.text,
    required this.controller,
    required this.hintText
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
                autocorrect: false,
                autofocus: false,
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
        ]
      )
    );
  }
}