import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'package:scial/enums/collection_enum.dart';
import 'package:scial/extensions/collection_extension.dart';
import 'package:scial/extensions/event_category_extension.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/models/user_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/services/auth_service.dart';
import 'package:scial/services/storage_service.dart';

abstract class BaseDatabaseService {
  Future<String?> get userImage;
  Future<UserModel?> get user;
  Future<List<EventModel>> get usersEvents;
  Future<bool> addEvent({ required EventModel eventModel, File? imageFile });
  Stream<List<EventModel>> streamEventsWithin({ required GeoFirePoint center, required double radius });
  Future<bool> uploadPhoto({ required File file });
}

class DatabaseService implements BaseDatabaseService {
  final Reader _read;

  const DatabaseService(this._read);

  FirebaseFirestore get firestore => _read(firebaseFirestoreProvider);
  Geoflutterfire get geoflutterfire => _read(geoflutterfireProvider);

  AuthService get authService => _read(authServiceProvider);
  StorageService get storageService => _read(storageServiceProvider);

  CollectionReference get usersReference => firestore.collection(CollectionEnum.USERS.ref);
  CollectionReference get eventsReference => firestore.collection(CollectionEnum.EVENTS.ref);

  @override
  Future<String?> get userImage async {
    try {
      DocumentSnapshot<Object?> snapshot = await usersReference.doc(authService.uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
        
        return map['image'];
      }
    } catch (e) {
      print('Unknown error');
    }

    return null;
  }

  @override
  Future<UserModel?> get user async {
    try {
      DocumentSnapshot<Object?> snapshot = await usersReference.doc(authService.uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
        return UserModel.fromMap(map);
      }
    } catch (e) {
      print('Unknown error');
    }

    return null;
  }

  @override
  Future<List<EventModel>> get usersEvents async {
    try {
      DocumentSnapshot<Object?> snapshot = await usersReference.doc(authService.uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

        List<String> eventIDs = List<String>.from(map['events']);

        List<EventModel> events = <EventModel>[];
        for (String eventID in eventIDs) {
          DocumentSnapshot<Object?> nestedSnapshot = await eventsReference.doc(eventID).get();

          if (nestedSnapshot.exists && nestedSnapshot.data() != null) {
            Map<String, dynamic> nestedMap = nestedSnapshot.data() as Map<String, dynamic>;
            events.add(EventModel.fromMap(nestedMap));
          }
        }

        return events;
      }
    } catch (e) {
      print('Unknown error');
    }

    return <EventModel>[];
  }

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

  @override
  Future<bool> uploadPhoto({ required File file }) async {

    // TODO: differentiate functions

    try {
      String? oldPhotoUrl;

      DocumentSnapshot<Object?> snapshot = await usersReference.doc(authService.uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

        oldPhotoUrl = map['image'];
      }

      if (oldPhotoUrl != null) {
        bool success = await storageService.deleteImage(oldPhotoUrl);

        if (!success) return false;
      }

      String? newPhotoUrl = await storageService.uploadImage(file);

      if (newPhotoUrl == null) return false;

      await usersReference.doc(authService.uid).update({ 'image' : newPhotoUrl });

      return true;
    } catch (e) {
      print('Unknown error');
    }
    // find in storage and delete if there
    // add to storage and get string
    // store sstring in users image parameter
    // TODO
    return false;
  }
}