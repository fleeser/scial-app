import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/services/places_service.dart';

import 'package:scial/themes/palette.dart';

class ProfileButton extends ConsumerWidget {

  const ProfileButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final PlacesService service = watch(placesServiceProvider);

    return SizedBox(
      height: kToolbarHeight - 10.0,
      width: kToolbarHeight - 10.0,
      child: RawMaterialButton(
        onPressed: () async {
          List<MapBoxPlace> list = await service.searchPlace("hallo");
          list.forEach((element) {
            
          });
        },
        fillColor: Palette.gray900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
      )
    );
  }
}