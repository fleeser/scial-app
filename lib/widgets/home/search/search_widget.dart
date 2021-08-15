import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/providers/providers.dart';
import 'package:scial/widgets/home/search/location_button.dart';
import 'package:scial/widgets/home/search/profile_button.dart';
import 'package:scial/widgets/home/search/search_bar.dart';
import 'package:scial/widgets/home/search/search_results.dart';

class SearchWidget extends ConsumerWidget {

  const SearchWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final bool isOpen = watch(searchIsOpenProvider);
    final String input = watch(searchInputProvider);

    return Column(
      children: children(isOpen: isOpen, input: input)
    );
  }
}

List<Widget> children({ required bool isOpen, required String input }) {
  List<Widget> list = <Widget>[
    Row(
      children: [
        Expanded(
          child: SearchBar()
        ),
        SizedBox(width: 24.0),
        ProfileButton()
      ]
    )
  ];

  if (isOpen) {
    list.addAll([
      SizedBox(height: 10.0),
      LocationButton()
    ]);
  }

  if (isOpen && input.isNotEmpty) {
    list.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 24.0
          ),
          child: SearchResults(input: input)
        )
      )
    );
  }

  return list;
}