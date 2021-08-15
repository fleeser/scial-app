import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:scial/providers/providers.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';
import 'package:scial/widgets/home/search/search_results_list.dart';

class SearchResults extends ConsumerWidget {

  final String input;

  const SearchResults({ 
    Key? key,
    required this.input
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<List<MapBoxPlace>> places = watch(placesSearchFutureProvider(input));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Palette.gray900
      ),
      child: places.when(
        data: (List<MapBoxPlace> placesList) => placesList.length == 0 ? Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'no_places_found'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Palette.gray400,
                height: 1.6
              )
            )
          )
        ) : SearchResultsList(places: placesList),
        loading: () => Center(
          child: CustomLoadingIndicator(size: 16.0, color: Palette.gray100)
        ), 
        error: (Object e, StackTrace? s) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'error_loading'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Palette.gray400,
                height: 1.6
              )
            )
          )
        )
      )
    );
  }
}