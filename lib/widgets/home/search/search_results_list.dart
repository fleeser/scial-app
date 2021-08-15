import 'package:flutter/material.dart';

import 'package:mapbox_search/mapbox_search.dart';

import 'package:scial/widgets/home/search/search_results_list_item.dart';

class SearchResultsList extends StatelessWidget {

  final List<MapBoxPlace> places;

  const SearchResultsList({ 
    Key? key,
    required this.places
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: places.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return SearchResultsListItem(place: places[index]);
      }
    );
  }
}