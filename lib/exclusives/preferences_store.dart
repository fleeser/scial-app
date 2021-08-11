import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStore extends TokenStore {

  static Future<PreferencesStore> create() async => PreferencesStore._internal(await SharedPreferences.getInstance());

  SharedPreferences _prefs;

  PreferencesStore._internal(this._prefs);

  @override
  Token? read() => _prefs.containsKey('auth_token') ? Token.fromMap(json.decode(_prefs.get('auth_token') as String)) : null;

  @override
  void write(Token? token) => token != null ? _prefs.setString('auth_token', json.encode(token.toMap())) : null;

  @override
  void delete() => _prefs.remove('auth_token');
}