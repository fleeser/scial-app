import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart' as FirebaseCoreStandard;
import 'package:firedart/firedart.dart' as FirebaseWindowsLinux;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/exclusives/preferences_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || !Platform.isLinux) FirebaseWindowsLinux.FirebaseAuth('AIzaSyDm9nOXkJAHXrwe3Tm9TIX4GAlSQjGC_og', await PreferencesStore.create());
  else await FirebaseCoreStandard.Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('de', 'DE')
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: App()
      )
    )
  );
}

class App extends StatelessWidget {

  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: Root()
    );
  }
}

class Root extends StatelessWidget {

  const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow);
  }
}