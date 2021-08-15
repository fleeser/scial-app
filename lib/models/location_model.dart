import 'package:scial/enums/location_state_enum.dart';

class LocationModel {
  final LocationStateEnum state;
  final double? latitude;
  final double? longitude;

  const LocationModel({
    required this.state,
    this.latitude,
    this.longitude
  });
}