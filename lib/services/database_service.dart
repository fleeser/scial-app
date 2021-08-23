import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'package:scial/enums/collection_enum.dart';
import 'package:scial/extensions/collection_extension.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/models/upload_event_model.dart';
import 'package:scial/models/user_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/services/auth_service.dart';
import 'package:scial/services/storage_service.dart';

abstract class BaseDatabaseService {
  Future<UserModel?> get user;
  Future<String?> get userImage;
  Future<List<String>> get userEvents;
  Future<bool> updateUserValue({ required String key, required dynamic value });
  Future<bool> uploadPhoto({ required File file });
  Future<bool> uploadEvent({ required UploadEventModel eventModel, File? image });
  Stream<List<EventModel>> streamEventsWithinRadiusFromCenter({ required double latitude, required double longitude, required double radius });
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

  DocumentReference<Object?>? get userDocument => authService.uid != null ? usersReference.doc(authService.uid!) : null;

  Future<DocumentSnapshot<Object?>?> get userSnapshot async => userDocument != null ? userDocument!.get() : null;

  @override
  Future<UserModel?> get user async {
    try {
      DocumentSnapshot<Object?>? snapshot = await userSnapshot;

      if (snapshot != null) {
        if (snapshot.exists && snapshot.data() != null) {
          	Map<String, dynamic> map = snapshot.data()! as Map<String, dynamic>;
            return UserModel.fromMap(map);
        }
      }
    } catch (e) {
      print('Unknown error');
    }

    return null;
  }

  @override
  Future<String?> get userImage async => (await user)?.imageUrl;

  @override
  Future<List<String>> get userEvents async => (await user)?.events ?? <String>[];

  @override
  Future<bool> updateUserValue({ required String key, required dynamic value }) async {
    if (userDocument != null) {
      try {
        await userDocument!.update({ "$key" : value });
        return true;
      } catch (e) {
        print('Unknown error');
      }
    }

    return false;
  }

  @override
  Future<bool> uploadPhoto({ required File file }) async {
    String? oldPhotoUrl = await userImage;

    if (oldPhotoUrl != null) {
      bool successDeletePhoto = await storageService.deleteImage(url: oldPhotoUrl);

      if (!successDeletePhoto) return false;
    }

    String? newPhotoUrl = await storageService.uploadImage(file: file);

    if (newPhotoUrl == null) return false;

    bool successUpdatePhotoUrl = await updateUserValue(key: 'image', value: newPhotoUrl);

    if (successUpdatePhotoUrl) return true;
    else return false;
  }

  @override
  Future<bool> uploadEvent({ required UploadEventModel eventModel, File? image }) async {

    String? imageUrl;
    if (image != null) {
      imageUrl = await storageService.uploadImage(file: image);

      if (imageUrl == null) return false;
    }

    Map<String, dynamic> map = eventModel.toMap();

    if (imageUrl != null) map['image'] = imageUrl;

    try {
      DocumentReference<Object?> reference = await eventsReference.add(map);
      bool success = await updateUserValue(key: 'events', value: FieldValue.arrayUnion([reference.id]));
      return success;
    } catch (e) {
      print('Unknown error');
    }

    return false;
  }



  @override
  Stream<List<EventModel>> streamEventsWithinRadiusFromCenter({ required double latitude, required double longitude, required double radius }) {
    return geoflutterfire.collection(collectionRef: eventsReference).within(center: GeoFirePoint(latitude, longitude), radius: radius, field: 'position').map((List<DocumentSnapshot<Map<String, dynamic>>> list) => list.map((DocumentSnapshot<Map<String, dynamic>> snapshot) => EventModel.fromMap(snapshot.data()!)).toList());
  }
}