import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:scial/enums/event_category_enum.dart';
import 'package:scial/extensions/event_category_extension.dart';

class EventModel {
  final double latitude;
  final double longitude;
  final String title;
  final String placeName;
  final String? imageUrl;
  final EventCategoryEnum eventCategoryEnum;

  const EventModel({
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.placeName,
    this.imageUrl,
    required this.eventCategoryEnum
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      latitude: (Map<String, dynamic>.from(map['position'])['geopoint'] as GeoPoint).latitude,
      longitude: (Map<String, dynamic>.from(map['position'])['geopoint'] as GeoPoint).longitude,
      title: map['title'],
      placeName: map['placeName'],
      imageUrl: map['imageUrl'],
      eventCategoryEnum: categoryFromValue(map['category'])
    );
  }
}