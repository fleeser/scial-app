import 'package:flutter/material.dart';

import 'package:mapbox_search/mapbox_search.dart';

import 'package:scial/models/search_model.dart';
import 'package:scial/widgets/search/search_menu_list_item.dart';

class SearchMenuList extends StatelessWidget {

  final List<MapBoxPlace> places;
  final Function(SearchModel) onItemPressed;

  const SearchMenuList({ 
    Key? key,
    required this.places,
    required this.onItemPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return SearchMenuListItem(place: places[index], isLastItem: index == places.length - 1, onItemPressed: (SearchModel searchModel) => onItemPressed(searchModel));
      }
    );
  }
}