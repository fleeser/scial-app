import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomMap extends StatelessWidget {

  const CustomMap({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://api.mapbox.com/styles/v1/fleeser/cks82ifob6r6018qqipcccm1s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M2dG9jeWYxNm5mMnBwaHphMWk1OXUxIn0.YwaINf8LeWwLzeUtmsRPSQ',
          additionalOptions: {
            'accessToken' : 'pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M2dG9jeWYxNm5mMnBwaHphMWk1OXUxIn0.YwaINf8LeWwLzeUtmsRPSQ',
            'id' : 'mapbox.mapbox-streets-v8'
          }
        )
      ]
    );
  }
}