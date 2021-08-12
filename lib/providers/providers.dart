import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

import 'package:scial/services/auth_service.dart';
import 'package:scial/providers/provider_classes.dart';
import 'package:scial/services/location_service.dart';

// FIREBASE

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// LOCATION

final locationProvider = Provider<Location>((ref) => Location.instance);

// SERVICES

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref.read));

final locationServiceProvider = Provider<LocationService>((ref) => LocationService(ref.read));

// USER

final authStateProvider = StreamProvider<User?>((ref) => ref.watch(authServiceProvider).authStateChanges);

// SIGN IN

final signInIsLoadingProvider = StateNotifierProvider.autoDispose<BooleanStartingWithFalseStateNotifier, bool>((ref) => BooleanStartingWithFalseStateNotifier());

final signInObscureTextProvider = StateNotifierProvider.autoDispose<BooleanStartingWithTrueStateNotifier, bool>((ref) => BooleanStartingWithTrueStateNotifier());

// HOME

final currentLocationFutureProvider = FutureProvider<LocationData>((ref) => ref.watch(locationServiceProvider).currentLocation);