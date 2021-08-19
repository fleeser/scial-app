import 'package:flutter/material.dart';
import 'package:scial/models/event_model.dart';

import 'package:seafarer/seafarer.dart';

import 'package:scial/args/details_screen_args.dart';
import 'package:scial/screens/details/details_screen.dart';

class Routes {
  static final seafarer = Seafarer();

  static void createRoutes() {
    seafarer.addRoutes(<SeafarerRoute>[
      SeafarerRoute(
        name: '/details',
        builder: (BuildContext context, BaseArguments? args, ParamMap params) {
          return DetailsScreen(args: args as DetailsScreenArgs);
        }
      )
    ]);
  }

  static void navigateBack() => seafarer.pop();

  static void navigateToDetailsScreen({ required EventModel event }) => seafarer.navigate('/details', args: DetailsScreenArgs(event: event));
}