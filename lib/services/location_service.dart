import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

import 'package:scial/providers/providers.dart';

abstract class BaseLocationService {
  Future<LocationData> get currentLocation;
}

class LocationService implements BaseLocationService {
  final Reader _read;

  const LocationService(this._read);

  Location get location => _read(locationProvider);

  @override
  Future<LocationData> get currentLocation async => await location.getLocation();
}