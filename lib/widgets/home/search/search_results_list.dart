import 'package:flutter/material.dart';

import 'package:mapbox_search/mapbox_search.dart';

import 'package:scial/themes/palette.dart';

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
        return SizedBox(
          height: 60.0,
          child: RawMaterialButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Icon(
                  Icons.place_rounded,
                  size: 24.0,
                  color: Palette.gray400
                ),
                SizedBox(width: 24.0),
                Expanded(
                  child: Text(
                    places[index].placeName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.gray100,
                      height: 1.6
                    )
                  )
                )
              ]
            )
          )
        );
      }
    );
  }
}