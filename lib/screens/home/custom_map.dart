import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:scial/themes/custom_system_ui_overlay_styles.dart';
import 'package:scial/themes/palette.dart';

class CustomMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: CustomSystemUiOverlayStyles.dark,
      child: Scaffold(
        backgroundColor: Palette.gray900,
        body: FlutterMap(
          options: MapOptions(center: LatLng(66.5, -0.09)),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://api.mapbox.com/styles/v1/fleeser/cks82ifob6r6018qqipcccm1s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M2dG9jeWYxNm5mMnBwaHphMWk1OXUxIn0.YwaINf8LeWwLzeUtmsRPSQ',
              additionalOptions: {
                'accessToken' : 'pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M2dG9jeWYxNm5mMnBwaHphMWk1OXUxIn0.YwaINf8LeWwLzeUtmsRPSQ',
                'id' : 'mapbox.mapbox-streets-v8'
              }
            )
          ]
        )
      )
    );
  }
}