import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'package:scial/enums/collection_enum.dart';
import 'package:scial/extensions/collection_extension.dart';
import 'package:scial/extensions/event_category_extension.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/providers/providers.dart';

abstract class BaseDatabaseService {
  Future<bool> addEvent(EventModel eventModel);
  Stream<List<EventModel>> streamEventsWithin({ required GeoFirePoint center, required double radius });
}

class DatabaseService implements BaseDatabaseService {
  final Reader _read;

  const DatabaseService(this._read);

  FirebaseFirestore get firestore => _read(firebaseFirestoreProvider);
  Geoflutterfire get geoflutterfire => _read(geoflutterfireProvider);

  CollectionReference get eventsReference => firestore.collection(CollectionEnum.EVENTS.ref);

  Future<bool> addEvent(EventModel eventModel) async {
    try {
      await eventsReference.add({
        'title' : eventModel.title,
        'category' : eventModel.eventCategoryEnum.value,
        'position' : geoflutterfire.point(latitude: eventModel.latitude, longitude: eventModel.longitude).data
      });
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

      eventsList.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        list.add(EventModel.fromMap(map));
      });

      return list;
    });
  }
}