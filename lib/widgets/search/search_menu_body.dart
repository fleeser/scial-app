import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:scial/models/search_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';
import 'package:scial/widgets/search/search_menu_list.dart';

class SearchMenuBody extends ConsumerWidget {

  final String input;
  final Function(SearchModel) onItemPressed;

  const SearchMenuBody({ 
    Key? key,
    required this.input,
    required this.onItemPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    
    final AsyncValue<List<MapBoxPlace>> places = watch(placesSearchFutureProvider(input));

    return places.when(
      data: (List<MapBoxPlace> placesList) => placesList.length == 0 ? Container(
        height: 52.0,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 24.0 - 24.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Palette.gray700,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0))
        ),
        child: Text(
          'no_places_found'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Palette.gray100,
            height: 1.6
          )
        )
      ) : Container(
        height: placesList.length >= 3 ? 156.0 : placesList.length * 52.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Palette.gray700,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0))
        ),
        child: SearchMenuList(places: placesList, onItemPressed: (SearchModel searchModel) => onItemPressed(searchModel))
      ),
      loading: () => Container(
        height: 52.0,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 24.0 - 24.0,
        decoration: BoxDecoration(
          color: Palette.gray700,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0))
        ),
        child: CustomLoadingIndicator(size: 16.0, color: Palette.gray100)
      ), 
      error: (Object e, StackTrace? s) => Container(
        height: 52.0,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 24.0 - 24.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Palette.gray700,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0))
        ),
        child: Text(
          'error_loading'.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Palette.gray100,
            height: 1.6
          )
        )
      )
    );
  }
}