import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/dropdown/custom_dropdown_list.dart';

class CustomDropdownBody extends StatelessWidget {

  final Function(int) onItemPressed;
  final List<String> items;

  const CustomDropdownBody({ 
    Key? key,
    required this.onItemPressed,
    required this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: items.length >= 3 ? 52.0 * 3 : 52.0 * items.length,
      decoration: BoxDecoration(
        color: Palette.gray700,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0))
      ),
      child: CustomDropdownList(items: items, onItemPressed: (int index) => onItemPressed(index))
    );
  }
}