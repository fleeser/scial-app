import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuthStandard;
import 'package:firedart/firedart.dart' as FirebaseWindowsLinux;

import 'package:scial/services/auth_service.dart';
import 'package:scial/providers/provider_classes.dart';

// FIREBASE

final firebaseStandardAuthProvider = Provider<FirebaseAuthStandard.FirebaseAuth>((ref) => FirebaseAuthStandard.FirebaseAuth.instance);
final firebaseWindowsLinuxAuthProvider = Provider<FirebaseWindowsLinux.FirebaseAuth>((ref) => FirebaseWindowsLinux.FirebaseAuth.instance);

// SERVICES

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref.read));

// USER

final authStateStandardProvider = StreamProvider<FirebaseAuthStandard.User?>((ref) => ref.watch(authServiceProvider).authStateChangesStandard);
final authStateWindowsLinuxProvider = StreamProvider<bool>((ref) => ref.watch(authServiceProvider).signInStateWindowsLinux);

// SIGN IN

final signInIsLoadingProvider = StateNotifierProvider.autoDispose<BooleanStartingWithFalseStateNotifier, bool>((ref) => BooleanStartingWithFalseStateNotifier());

final signInObscureTextProvider = StateNotifierProvider.autoDispose<BooleanStartingWithTrueStateNotifier, bool>((ref) => BooleanStartingWithTrueStateNotifier());