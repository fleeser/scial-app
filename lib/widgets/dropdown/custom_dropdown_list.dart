import 'package:flutter/material.dart';

import 'package:scial/widgets/dropdown/custom_dropdown_list_item.dart';

class CustomDropdownList extends StatelessWidget {

  final List<String> items;
  final Function(int) onItemPressed;

  const CustomDropdownList({ 
    Key? key,
    required this.items,
    required this.onItemPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return CustomDropdownListItem(
          item: items[index],
          index: index,
          isLastItem: index == items.length - 1,
          itemPressed: () => onItemPressed(index),
        );
      }
    );
  }
}