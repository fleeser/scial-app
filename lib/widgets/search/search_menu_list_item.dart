import 'package:flutter/material.dart';

import 'package:mapbox_search/mapbox_search.dart';

import 'package:scial/models/search_model.dart';
import 'package:scial/themes/palette.dart';

class SearchMenuListItem extends StatelessWidget {

  final MapBoxPlace place;
  final bool isLastItem;
  final Function(SearchModel) onItemPressed;

  const SearchMenuListItem({ 
    Key? key,
    required this.place,
    required this.isLastItem,
    required this.onItemPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.0,
      child: RawMaterialButton(
        onPressed: () {
          onItemPressed(SearchModel(name: place.placeName, latitude: place.center[0], longitude: place.center[1]));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(isLastItem ? 12.0 : 0.0))),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            place.placeName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.0,
              color: Palette.gray100,
              height: 1.6
            )
          )
        )
      )
    );
  }
}