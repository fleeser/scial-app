import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:scial/enums/selected_center_enum.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/palette.dart';

class SearchResultsListItem extends ConsumerWidget {

  final MapBoxPlace place;

  const SearchResultsListItem({ 
    Key? key,
    required this.place
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final SelectedCenterEnum selectedCenter = watch(selectedCenterProvider);
    final bool isOpen = watch(searchIsOpenProvider);
    final PanelController panelController = watch(panelControllerProvider);
    final MapController? mapController = watch(mapControllerProvider);
    final bool addFloatingActionButtonIsShown = watch(addFloatingActionButtonIsShownProvider);
    
    return SizedBox(
      height: 60.0,
      child: RawMaterialButton(
        onPressed: () async {
          if (mapController != null) {
            if (mapController.center != LatLng(place.center[0], place.center[1])) {
              mapController.move(LatLng(place.center[0], place.center[1]), 13.0);
            }
          }

          context.read(selectedPlaceProvider.notifier).update(place);
          
          if (selectedCenter != SelectedCenterEnum.PLACE) context.read(selectedCenterProvider.notifier).update(SelectedCenterEnum.PLACE);

          FocusScope.of(context).unfocus();
          if (isOpen) context.read(searchIsOpenProvider.notifier).trigger();
          if (!addFloatingActionButtonIsShown) context.read(addFloatingActionButtonIsShownProvider.notifier).trigger();
          if (!panelController.isPanelShown) await panelController.show();
        },
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
                place.placeName,
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
}