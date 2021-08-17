import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/providers/provider_classes.dart';
import 'package:scial/widgets/dropdown/custom_dropdown_body.dart';
import 'package:scial/widgets/dropdown/custom_dropdown_header.dart';

class CustomDropdown extends ConsumerWidget {

  final StateNotifierProvider<BooleanStartingWithFalseStateNotifier, bool> provider;
  final String title;
  final Function(int) onItemPressed;
  final List<String> items;

  const CustomDropdown({ 
    Key? key,
    required this.provider,
    required this.title,
    required this.onItemPressed,
    required this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final bool isOpen = watch(provider);

    return Container(
      height: isOpen ? items.length >= 3 ? 52.0 * 4 : 52.0 * (items.length + 1) : 52.0,
      child: Column(
        children: children(context: context, provider: provider, isOpen: isOpen, title: title, onItemPressed: onItemPressed, items: items)
      )
    );
  }
}

List<Widget> children({ required BuildContext context, required StateNotifierProvider<BooleanStartingWithFalseStateNotifier, bool> provider, required bool isOpen, required String title, required Function(int) onItemPressed, required List<String> items }) {
  List<Widget> list = <Widget>[
    CustomDropdownHeader(provider: provider, title: title)
  ];

  if (isOpen) {
    list.add(
      CustomDropdownBody(
        onItemPressed: (int index) {
          onItemPressed(index);
          context.read(provider.notifier).trigger();
        }, 
        items: items
      )
    );
  }

  return list;
}