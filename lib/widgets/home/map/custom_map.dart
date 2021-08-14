import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:scial/models/event_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/custom_system_ui_overlay_styles.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/extensions/event_category_extension.dart';

class CustomMap extends ConsumerWidget {

  const CustomMap({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<LocationData> locationData = watch(currentLocationFutureProvider);
    final AsyncValue<List<EventModel>> events = watch(eventsWithinStreamProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: CustomSystemUiOverlayStyles.dark,
      child: Scaffold(
        backgroundColor: Palette.gray900,
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(51.0, -0.09),
            onMapCreated: (MapController controller) async {
              LocationData locationData = await context.read(currentLocationFutureProvider.future);

              if (locationData.latitude != null && locationData.longitude != null) {
                controller.move(LatLng(locationData.latitude!, locationData.longitude!), 13.0);
              }
            }
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://api.mapbox.com/styles/v1/fleeser/cks82ifob6r6018qqipcccm1s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M4dzV3OTAwa280Mm5wZnI3Nndjc2cxIn0.hkto7RqB_ZxhzLR7hy5law',
              additionalOptions: {
                'accessToken' : 'pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M4dzV3OTAwa280Mm5wZnI3Nndjc2cxIn0.hkto7RqB_ZxhzLR7hy5law',
                'id' : 'mapbox.mapbox-streets-v8'
              }
            ),
            MarkerLayerOptions(
              markers: locationData.when(
                data: (LocationData locationData) {
                  if (locationData.latitude != null && locationData.longitude != null) {
                    return events.when(
                      data: (List<EventModel> eventsList) => markersFor(latitude: locationData.latitude!, longitude: locationData.longitude!, eventsList: eventsList), 
                      loading: () => <Marker>[
                        Marker(
                          point: LatLng(locationData.latitude!, locationData.longitude!),
                          width: 14.0,
                          height: 14.0,
                          builder: (BuildContext context) => Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Palette.blue500)) 
                        )
                      ], 
                      error: (Object e, StackTrace? s) => <Marker>[
                        Marker(
                          point: LatLng(locationData.latitude!, locationData.longitude!),
                          width: 14.0,
                          height: 14.0,
                          builder: (BuildContext context) => Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Palette.blue500)) 
                        )
                      ]
                    );
                  }

                  return <Marker>[];
                }, 
                loading: () => <Marker>[], 
                error: (Object e, StackTrace? s) => <Marker>[]
              )
            )
          ]
        )
      )
    );
  }
}

List<Marker> markersFor({ required double latitude, required double longitude, required List<EventModel> eventsList }) {
  List<Marker> list = <Marker>[
    Marker(
      point: LatLng(latitude, longitude),
      width: 14.0,
      height: 14.0,
      builder: (BuildContext context) => Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Palette.blue500)) 
    )            
  ];

  eventsList.forEach((EventModel event) {
    list.add(Marker(
      point: LatLng(event.latitude, event.longitude),
      width: 36.0,
      height: 36.0,
      builder: (BuildContext context) => Image(
        image: AssetImage('assets/icons/pin.png'),
        color: event.eventCategoryEnum.color
      )
    ));
  });

  return list;
}