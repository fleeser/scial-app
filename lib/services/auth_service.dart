import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:scial/providers/providers.dart';

abstract class BaseAuthService {
  String? get uid;
  Stream<bool> get isLoggedIn;
  Future<void> signIn({ required String email, required String password });
}

class AuthService implements BaseAuthService {
  final Reader _read;

  const AuthService(this._read);

  FirebaseAuth get auth => _read(firebaseAuthProvider);

  @override
  String? get uid => auth.currentUser?.uid;

  @override
  Stream<bool> get isLoggedIn => auth.authStateChanges().map((User? user) => user == null ? false : true);

  @override
  Future<void> signIn({ required String email, required String password }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found': print('User not found'); break;
        case 'wrong-password': print('Wrong password'); break;
        default: print('Unknown error');
      }
    } catch (e) {
      print('Unknown error');
    }
  }
}