import 'dart:io';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';

import 'package:scial/enums/selected_center_enum.dart';
import 'package:scial/models/search_model.dart';

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

class SelectedCenterStartingWithLocationStateNotifier extends StateNotifier<SelectedCenterEnum> {
  SelectedCenterStartingWithLocationStateNotifier() : super(SelectedCenterEnum.LOCATION);

  void update(SelectedCenterEnum value) => state = value;
}

class SelectedPlaceStartingWithNullStateNotifier extends StateNotifier<MapBoxPlace?> {
  SelectedPlaceStartingWithNullStateNotifier() : super(null);

  void update(MapBoxPlace? value) => state = value;
}

class MapControllerStartingWithNullStateNotifier extends StateNotifier<MapController?> {
  MapControllerStartingWithNullStateNotifier() : super(null);

  void update(MapController controller) => state = controller;
}

class DoubleStartingWithGivenValueStateNotifier extends StateNotifier<double> {
  final double startingValue;

  DoubleStartingWithGivenValueStateNotifier(this.startingValue) : super(startingValue);

  void changeTo(double value) => state = value;
}

class IntegerStartingWithNullStateNotifierProvider extends StateNotifier<int?> {
  IntegerStartingWithNullStateNotifierProvider() : super(null);

  void update(int value) => state = value;
}

class SearchModelStartingWithNullStateNotifierProvider extends StateNotifier<SearchModel?> {
  SearchModelStartingWithNullStateNotifierProvider() : super(null);

  void update(SearchModel value) => state = value;
}

class FileStartingWithNullStateNotifier extends StateNotifier<File?> {
  FileStartingWithNullStateNotifier() : super(null);

  void update(File? value) => state = value;
}