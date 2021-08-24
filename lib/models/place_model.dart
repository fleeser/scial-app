import 'package:mapbox_search/mapbox_search.dart';

class PlaceModel {
  final String placeName;
  final double latitude;
  final double longitude;

  const PlaceModel({
    required this.placeName,
    required this.latitude,
    required this.longitude
  });

  factory PlaceModel.fromMapBoxPlace(MapBoxPlace place) {
    return PlaceModel(
      placeName: place.placeName!,
      latitude: place.center![0],
      longitude: place.center![1]
    );
  }
}