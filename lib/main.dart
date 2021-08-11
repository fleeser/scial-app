import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart' as FirebaseCoreStandard;
import 'package:firedart/firedart.dart' as FirebaseWindowsLinux;
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuthStandard;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:scial/exclusives/preferences_store.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/screens/auth/sign_in/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) FirebaseWindowsLinux.FirebaseAuth.initialize('AIzaSyDm9nOXkJAHXrwe3Tm9TIX4GAlSQjGC_og', await PreferencesStore.create());
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

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    doWhenWindowReady(() {
      appWindow.minSize = Size(600, 450);
      appWindow.size = Size(600, 450);
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
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

class Root extends ConsumerWidget {

  const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      final AsyncValue<bool> authStateWindowsLinux = watch(authStateWindowsLinuxProvider);

      return authStateWindowsLinux.when(
        data: (bool isSignedIn) => isSignedIn ? Container(color: Colors.green) : SignInScreen(),
        loading: () => Container(color: Colors.yellow), 
        error: (Object e, StackTrace? s) => Container(color: Colors.red)
      );
    }

    final AsyncValue<FirebaseAuthStandard.User?> authStateStandard = watch(authStateStandardProvider);

    return authStateStandard.when(
      data: (FirebaseAuthStandard.User? user) => user != null ? Container(color: Colors.green) : SignInScreen(),
      loading: () => Container(color: Colors.yellow), 
      error: (Object e, StackTrace? s) => Container(color: Colors.red)
    );
  }
}