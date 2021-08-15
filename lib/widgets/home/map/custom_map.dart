import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:scial/enums/event_list_state_enum.dart';

import 'package:scial/extensions/event_category_extension.dart';
import 'package:scial/enums/location_state_enum.dart';
import 'package:scial/models/event_list_model.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/models/location_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/custom_system_ui_overlay_styles.dart';
import 'package:scial/themes/palette.dart';

class CustomMap extends ConsumerWidget {

  const CustomMap({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<LocationModel> locationModel = watch(currentLocationFutureProvider);
    final AsyncValue<EventListModel> events = watch(eventsWithinStreamProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: CustomSystemUiOverlayStyles.dark,
      child: Scaffold(
        backgroundColor: Palette.gray900,
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(51.0, -0.09),
            onMapCreated: (MapController controller) async {
              context.read(mapControllerProvider.notifier).update(controller);

              LocationModel locationModel = await context.read(currentLocationFutureProvider.future);

              if (locationModel.state == LocationStateEnum.SUCCESS) {
                controller.move(LatLng(locationModel.latitude!, locationModel.longitude!), 13.0);
              }
            }
          ),
          nonRotatedLayers: [
            TileLayerOptions(
              urlTemplate: 'https://api.mapbox.com/styles/v1/fleeser/cks82ifob6r6018qqipcccm1s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M4dzV3OTAwa280Mm5wZnI3Nndjc2cxIn0.hkto7RqB_ZxhzLR7hy5law',
              additionalOptions: {
                'accessToken' : 'pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M4dzV3OTAwa280Mm5wZnI3Nndjc2cxIn0.hkto7RqB_ZxhzLR7hy5law',
                'id' : 'mapbox.mapbox-streets-v8'
              }
            ),
            MarkerLayerOptions(
              markers: markers(locationModel: locationModel, events: events)
            )
          ]
        )
      )
    );
  }
}

List<Marker> markers({ required AsyncValue<LocationModel> locationModel, required AsyncValue<EventListModel> events }) {
  List<Marker> list = <Marker>[];

  locationModel.whenData((LocationModel locationModelVal) {
    if (locationModelVal.state == LocationStateEnum.SUCCESS) {
      list.add(
        Marker(
          point: LatLng(locationModelVal.latitude!, locationModelVal.longitude!),
          width: 14.0,
          height: 14.0,
          builder: (BuildContext context) {
            return Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Palette.blue500));
          }
        )
      );
    }
  });

  events.whenData((EventListModel eventListModel) {
    if (eventListModel.state == EventListStateEnum.SUCCESS) {
      list.addAll(
        eventListModel.events!.map((EventModel event) => Marker(
          point: LatLng(event.latitude, event.longitude),
          width: 14.0,
          height: 14.0,
          builder: (BuildContext context) {
            return Container(decoration: BoxDecoration(shape: BoxShape.circle, color: event.eventCategoryEnum.color));
          }
        ))
      );
    }
  });

  return list;
}