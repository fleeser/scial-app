import 'package:flutter/material.dart';

import 'package:scial/themes/palette.dart';

class SearchBar extends StatelessWidget {

  const SearchBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight - 10.0,
      decoration: BoxDecoration(
        color: Palette.gray900,
        borderRadius: BorderRadius.circular(12.0)
      )
    );
  }
}