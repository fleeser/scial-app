import 'package:seafarer/seafarer.dart';

class Routes {
  static final seafarer = Seafarer();

  static void createRoutes() {}

  static void navigateBack() => seafarer.pop();
}