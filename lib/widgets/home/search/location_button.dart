import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:scial/enums/selected_center_enum.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/enums/location_state_enum.dart';
import 'package:scial/models/location_model.dart';

class LocationButton extends ConsumerWidget {

  const LocationButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final SelectedCenterEnum selectedCenter = watch(selectedCenterProvider);
    final bool isOpen = watch(searchIsOpenProvider);
    final PanelController panelController = watch(panelControllerProvider);
    final MapController? mapController = watch(mapControllerProvider);
    
    return RawMaterialButton(
      onPressed: () async {
        if (mapController != null) {
          LocationModel locationModel = await context.read(currentLocationFutureProvider.future);
          
          if (locationModel.state == LocationStateEnum.SUCCESS) {
            if (mapController.center != LatLng(locationModel.latitude!, locationModel.longitude!)) {
              mapController.move(LatLng(locationModel.latitude!, locationModel.longitude!), 13.0);
            }
          }
        }
        
        if (selectedCenter != SelectedCenterEnum.LOCATION) {
          context.read(selectedCenterProvider.notifier).update(SelectedCenterEnum.LOCATION);
          context.read(selectedPlaceProvider.notifier).update(null);
        } else context.refresh(currentLocationFutureProvider);

        FocusScope.of(context).unfocus();
        if (isOpen) context.read(searchIsOpenProvider.notifier).trigger();
        if (!panelController.isPanelShown) await panelController.show();
      },
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      fillColor: Palette.gray900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        children: [
          Icon(
            Icons.my_location_rounded,
            size: 24.0,
            color: Palette.blue500
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Text(
              'use_my_location'.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Palette.gray100,
                height: 1.0
              )
            )
          )
        ]
      )
    );
  }
}