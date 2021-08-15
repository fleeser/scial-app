import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooleanStartingWithFalseStateNotifier extends StateNotifier<bool> {
  BooleanStartingWithFalseStateNotifier() : super(false);

  void trigger() => state = !state;
}

class BooleanStartingWithTrueStateNotifier extends StateNotifier<bool> {
  BooleanStartingWithTrueStateNotifier() : super(true);

  void trigger() => state = !state;
}

class StringStartingWithEmptyStateNotifier extends StateNotifier<String> {
  StringStartingWithEmptyStateNotifier() : super("");

  void update(String value) => state = value;
}