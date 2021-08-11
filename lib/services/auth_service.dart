import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuthStandard;
import 'package:firedart/firedart.dart' as FirebaseWindowsLinux;
import 'package:firedart/auth/exceptions.dart' as FirebaseAuthWindowsLinuxExceptions;

import 'package:scial/providers/providers.dart';

abstract class BaseAuthService {
  Stream<FirebaseAuthStandard.User?> get authStateChangesStandard;
  Stream<bool> get signInStateWindowsLinux;

  Future<bool> signIn({ required String email, required String password });
}

class AuthService implements BaseAuthService {
  final Reader _read;

  const AuthService(this._read);

  FirebaseAuthStandard.FirebaseAuth get authStandard => _read(firebaseStandardAuthProvider);
  FirebaseWindowsLinux.FirebaseAuth get authWindowsLinux => _read(firebaseWindowsLinuxAuthProvider);

  @override
  Stream<FirebaseAuthStandard.User?> get authStateChangesStandard => authStandard.authStateChanges();

  @override
  Stream<bool> get signInStateWindowsLinux => authWindowsLinux.signInState;

  @override
  Future<bool> signIn({ required String email, required String password }) async {
    try {
      if (Platform.isWindows || Platform.isLinux) await authWindowsLinux.signIn(email, password);
      else await authStandard.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthStandard.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found': print('User not found'); break;
        case 'wrong-password': print('Wrong password'); break;
        default: print('Unknown error');
      }
    } on FirebaseAuthWindowsLinuxExceptions.AuthException catch (e) {
      switch (e.errorCode) {
        case 'INVALID_PASSWORD': print('Wrong password'); break;
        case 'EMAIL_NOT_FOUND': print('User not found'); break;
        default: print('Unknown error');
      }
    } catch (e) {
      print('Unknown error');
    }

    return false;
  }
}