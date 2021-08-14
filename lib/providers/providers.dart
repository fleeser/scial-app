import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

import 'package:scial/models/event_model.dart';
import 'package:scial/services/auth_service.dart';
import 'package:scial/providers/provider_classes.dart';
import 'package:scial/services/database_service.dart';
import 'package:scial/services/location_service.dart';

// FIREBASE

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// GEO

final geoflutterfireProvider = Provider<Geoflutterfire>((ref) => Geoflutterfire());

// LOCATION

final locationProvider = Provider<Location>((ref) => Location.instance);

// SERVICES

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref.read));

final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService(ref.read));

final locationServiceProvider = Provider<LocationService>((ref) => LocationService(ref.read));

// USER

final authStateProvider = StreamProvider<User?>((ref) => ref.watch(authServiceProvider).authStateChanges);

// SIGN IN

final signInIsLoadingProvider = StateNotifierProvider.autoDispose<BooleanStartingWithFalseStateNotifier, bool>((ref) => BooleanStartingWithFalseStateNotifier());

final signInObscureTextProvider = StateNotifierProvider.autoDispose<BooleanStartingWithTrueStateNotifier, bool>((ref) => BooleanStartingWithTrueStateNotifier());

// HOME

final currentLocationFutureProvider = FutureProvider<LocationData>((ref) => ref.watch(locationServiceProvider).currentLocation);

final eventsWithinStreamProvider = StreamProvider<List<EventModel>>((ref) {
  final AsyncValue<LocationData> locationData = ref.watch(currentLocationFutureProvider);

  if (locationData.data != null && locationData.data!.value.latitude != null && locationData.data!.value.longitude != null) {
    return ref.read(databaseServiceProvider).streamEventsWithin(center: GeoFirePoint(locationData.data!.value.latitude!, locationData.data!.value.longitude!), radius: double.infinity);
  }

  return Stream.value(<EventModel>[]);
});