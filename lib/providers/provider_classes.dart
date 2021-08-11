import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooleanStartingWithFalseStateNotifier extends StateNotifier<bool> {
  BooleanStartingWithFalseStateNotifier() : super(false);

  void trigger() => state = !state;
}