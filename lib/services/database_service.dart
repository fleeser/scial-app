import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'package:scial/enums/collection_enum.dart';
import 'package:scial/extensions/collection_extension.dart';
import 'package:scial/extensions/event_category_extension.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/services/storage_service.dart';

abstract class BaseDatabaseService {
  Future<bool> addEvent({ required EventModel eventModel, File? imageFile });
  Stream<List<EventModel>> streamEventsWithin({ required GeoFirePoint center, required double radius });
}

class DatabaseService implements BaseDatabaseService {
  final Reader _read;

  const DatabaseService(this._read);

  FirebaseFirestore get firestore => _read(firebaseFirestoreProvider);
  Geoflutterfire get geoflutterfire => _read(geoflutterfireProvider);

  StorageService get storageService => _read(storageServiceProvider);

  CollectionReference get eventsReference => firestore.collection(CollectionEnum.EVENTS.ref);

  @override
  Future<bool> addEvent({ required EventModel eventModel, File? imageFile }) async {

    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await storageService.uploadImage(imageFile);
    }

    Map<String, dynamic> map = {
      'title' : eventModel.title,
      'category' : eventModel.eventCategoryEnum.value,
      'position' : geoflutterfire.point(latitude: eventModel.latitude, longitude: eventModel.longitude).data,
      'placeName' : eventModel.placeName
    };

    if (imageUrl != null) map['imageUrl'] = imageUrl;

    try {
      await eventsReference.add(map);
      return true;
    } catch (e) {
      print('Unknown error');
    }

    return false;
  }

  @override
  Stream<List<EventModel>> streamEventsWithin({ required GeoFirePoint center, required double radius }) {
    return geoflutterfire.collection(collectionRef: eventsReference).within(center: center, radius: radius, field: 'position').map((List<DocumentSnapshot<Map<String, dynamic>>> eventsList) {
      List<EventModel> list = <EventModel>[];
      
      eventsList.forEach((DocumentSnapshot<Map<String, dynamic>> snapshot) {
        list.add(EventModel.fromMap(snapshot.data()!));
      });

      return list;
    });
  }
}