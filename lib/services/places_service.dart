import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';

import 'package:scial/models/place_model.dart';
import 'package:scial/providers/providers.dart';

abstract class BasePlacesService {
  Future<List<PlaceModel>> searchPlaces(String input);
}

class PlacesService implements BasePlacesService {
  final Reader _read;

  const PlacesService(this._read);

  PlacesSearch get places => _read(placesProvider);

  @override
  Future<List<PlaceModel>> searchPlaces(String input) async {
    List<MapBoxPlace>? mapBoxPlaces = await places.getPlaces(input);

    if (mapBoxPlaces != null) {
      mapBoxPlaces.removeWhere((MapBoxPlace mapBoxPlace) => (mapBoxPlace.placeName == null || mapBoxPlace.center == null));
      return mapBoxPlaces.map((MapBoxPlace mapBoxPlace) => PlaceModel.fromMapBoxPlace(mapBoxPlace)).toList();
    } else return <PlaceModel>[];
  }
}