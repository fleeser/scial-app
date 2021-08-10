import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuthStandard;
import 'package:firedart/firedart.dart' as FirebaseWindowsLinux;

// FIREBASE

final firebaseStandardAuthProvider = Provider<FirebaseAuthStandard.FirebaseAuth>((ref) => FirebaseAuthStandard.FirebaseAuth.instance);
final firebaseWindowsLinuxAuthProvider = Provider<FirebaseWindowsLinux.FirebaseAuth>((ref) => FirebaseWindowsLinux.FirebaseAuth.instance);