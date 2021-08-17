import 'package:flutter/material.dart';

import 'package:scial/widgets/custom_text_field.dart';

class SearchMenuHeader extends StatelessWidget {

  final String input;
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;

  const SearchMenuHeader({ 
    Key? key,
    required this.input,
    required this.hintText,
    required this.onChanged,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      onChanged: (String text) => onChanged(text),
      icon: Icons.place_rounded,
      hintText: hintText,
      borderRadius: input.isNotEmpty ? BorderRadius.vertical(top: Radius.circular(12.0)) : BorderRadius.circular(12.0)
    );
  }
}