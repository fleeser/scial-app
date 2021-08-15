import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

import 'package:scial/models/location_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/enums/location_state_enum.dart';

abstract class BaseLocationService {
  Future<LocationModel> get currentLocation;
}

class LocationService implements BaseLocationService {
  final Reader _read;

  const LocationService(this._read);

  Location get location => _read(locationProvider);

  @override
  Future<LocationModel> get currentLocation async {
    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return LocationModel(state: LocationStateEnum.DENIED);
    }

    PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) return LocationModel(state: LocationStateEnum.DENIED);
    }

    LocationData locationData = await location.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) return LocationModel(state: LocationStateEnum.FAIL);

    return LocationModel(state: LocationStateEnum.SUCCESS, latitude: locationData.latitude!, longitude: locationData.longitude!);
  }
}