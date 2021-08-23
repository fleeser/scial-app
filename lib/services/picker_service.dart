import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:scial/providers/providers.dart';

abstract class BasePickerService {
  Future<File?> pickImageFromGallery();
}

class PickerService implements BasePickerService {
  final Reader _read;

  const PickerService(this._read);

  ImagePicker get imagePicker => _read(imagePickerProvider);
  FilePicker get filePicker => _read(filePickerProvider);

  @override
  Future<File?> pickImageFromGallery() async {

    if (!kIsWeb && Platform.isMacOS) {
      FilePickerResult? result = await filePicker.pickFiles();
      if (result != null) {
        String? path = result.files.single.path;
        if (path != null) return File(path);
      }
    } else {
      XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (xFile != null) return File(xFile.path);
    }

    return null;
  }
}