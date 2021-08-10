import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: App()));

class App extends StatelessWidget {

  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root()
    );
  }
}

class Root extends StatelessWidget {

  const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}