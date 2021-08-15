import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:mapbox_search/mapbox_search.dart' hide Location;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:scial/enums/event_list_state_enum.dart';
import 'package:scial/enums/location_state_enum.dart';
import 'package:scial/models/event_list_model.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/models/location_model.dart';
import 'package:scial/services/auth_service.dart';
import 'package:scial/providers/provider_classes.dart';
import 'package:scial/services/database_service.dart';
import 'package:scial/services/location_service.dart';
import 'package:scial/services/places_service.dart';

// FIREBASE

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// GEO

final geoflutterfireProvider = Provider<Geoflutterfire>((ref) => Geoflutterfire());

// LOCATION

final locationProvider = Provider<Location>((ref) => Location.instance);

// PLACES

final placesProvider = Provider<PlacesSearch>((ref) => PlacesSearch(apiKey: 'pk.eyJ1IjoiZmxlZXNlciIsImEiOiJja3M4dzV3OTAwa280Mm5wZnI3Nndjc2cxIn0.hkto7RqB_ZxhzLR7hy5law', limit: 5));

// SERVICES

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref.read));

final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService(ref.read));

final locationServiceProvider = Provider<LocationService>((ref) => LocationService(ref.read));

final placesServiceProvider = Provider<PlacesService>((ref) => PlacesService(ref.read));

// USER

final authStateProvider = StreamProvider<User?>((ref) => ref.watch(authServiceProvider).authStateChanges);

// SIGN IN

final signInIsLoadingProvider = StateNotifierProvider.autoDispose<BooleanStartingWithFalseStateNotifier, bool>((ref) => BooleanStartingWithFalseStateNotifier());

final signInObscureTextProvider = StateNotifierProvider.autoDispose<BooleanStartingWithTrueStateNotifier, bool>((ref) => BooleanStartingWithTrueStateNotifier());

// HOME

final currentLocationFutureProvider = FutureProvider<LocationModel>((ref) => ref.watch(locationServiceProvider).currentLocation);

final eventsWithinStreamProvider = StreamProvider<EventListModel>((ref) {
  final AsyncValue<LocationModel> locationModel = ref.watch(currentLocationFutureProvider);

  if (locationModel.data == null) return Stream.value(EventListModel(state: EventListStateEnum.WAITING));

  if (locationModel.data!.value.state == LocationStateEnum.DENIED) return Stream.value(EventListModel(state: EventListStateEnum.DENIED));

  if (locationModel.data!.value.state == LocationStateEnum.FAIL) return Stream.value(EventListModel(state: EventListStateEnum.FAIL));

  return ref.read(databaseServiceProvider).streamEventsWithin(center: GeoFirePoint(locationModel.data!.value.latitude!, locationModel.data!.value.longitude!), radius: double.infinity).map((List<EventModel> events) => EventListModel(state: EventListStateEnum.SUCCESS, events: events));
});

final placesSearchFutureProvider = FutureProvider.family<List<MapBoxPlace>, String>((ref, value) => ref.read(placesServiceProvider).searchPlace(value));

final panelControllerProvider = Provider<PanelController>((ref) => PanelController());

final searchInputProvider = StateNotifierProvider<StringStartingWithEmptyStateNotifier, String>((ref) => StringStartingWithEmptyStateNotifier());

final searchIsOpenProvider = StateNotifierProvider<BooleanStartingWithFalseStateNotifier, bool>((ref) => BooleanStartingWithFalseStateNotifier());