import 'dart:io';

import 'package:geoflutterfire/geoflutterfire.dart';

class UploadEventModel {
  final String title;
  final int category;
  final double latitude;
  final double longitude;
  final String placeName;
  final File? image;

  const UploadEventModel({
    required this.title,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.placeName,
    this.image
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title' : title,
      'category' : category,
      'position' : GeoFirePoint(latitude, longitude).data,
      'placeName' : placeName
    };
  }
}