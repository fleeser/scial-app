import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/enums/child_enum.dart';
import 'package:scial/extensions/child_extension.dart';
import 'package:scial/providers/providers.dart';

abstract class BaseStorageService {
  Future<String?> uploadImage({ required File file });
  Future<bool> deleteImage({ required String url });
}

class StorageService implements BaseStorageService {
  final Reader _read;

  const StorageService(this._read);

  FirebaseStorage get storage => _read(firebaseStorageProvider);

  @override
  Future<String?> uploadImage({ required File file }) async {
    DateTime now = DateTime.now();
    
    String convertedDateTime = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}-${now.hour.toString().padLeft(2,'0')}-${now.minute.toString().padLeft(2,'0')}";

    try {
      TaskSnapshot snapshot = await storage.ref().child(ChildEnum.EVENT_IMAGES.childRef).child('$convertedDateTime.png').putFile(file);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Unknown error');
    }

    return null;
  }

  @override
  Future<bool> deleteImage({ required String url }) async {
    try {
      await storage.refFromURL(url).delete();
      return true;
    } catch (e) {
      print('Unknown error here');
    }

    return false;
  }
}