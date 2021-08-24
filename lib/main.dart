import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/providers/providers.dart';
import 'package:scial/routes.dart';
import 'package:scial/screens/sign_in/sign_in_screen.dart';
import 'package:scial/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();

  Routes.createRoutes();

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
      navigatorKey: Routes.seafarer.navigatorKey,
      onGenerateRoute: Routes.seafarer.generator(),
      debugShowCheckedModeBanner: false,
      home: Root()
    );
  }
}

class Root extends ConsumerWidget {

  const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<bool> isLoggedIn = watch(userIsLoggedInProvider);

    return isLoggedIn.when(
      data: (bool loggedIn) => loggedIn ? HomeScreen() : SignInScreen(),
      loading: () => Container(color: Colors.yellow), 
      error: (Object e, StackTrace? s) => Container(color: Colors.red)
    );
  }
}