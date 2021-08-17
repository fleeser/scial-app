import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/models/search_model.dart';
import 'package:scial/widgets/search/search_menu_body.dart';
import 'package:scial/widgets/search/search_menu_header.dart';

class SearchMenu extends ConsumerWidget {

  final String hintText;
  final Function(SearchModel) onItemPressed;
  final String input;
  final Function(String) onChanged;
  final TextEditingController controller;
  
  const SearchMenu({ 
    Key? key,
    required this.hintText,
    required this.onItemPressed,
    required this.input,
    required this.onChanged,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      height: input.isEmpty ? 52.0 : 300.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: children(context: context, input: input, hintText: hintText, onItemPressed: onItemPressed, controller: controller, onChanged: onChanged)
      )
    );
  }
}

List<Widget> children({ required BuildContext context, required String input, required String hintText, required Function(SearchModel) onItemPressed, required Function(String) onChanged, required TextEditingController controller }) {
  List<Widget> list = <Widget>[
    SearchMenuHeader(input: input, hintText: hintText, onChanged: onChanged, controller: controller)
  ];

  if (input.isNotEmpty) {
    list.add(
      SearchMenuBody(
        input: input, 
        onItemPressed: (SearchModel searchModel) => onItemPressed(searchModel)
      )
    );
  }

  return list;
}