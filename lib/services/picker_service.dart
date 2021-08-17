import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:scial/providers/providers.dart';

abstract class BasePickerService {
  Future<XFile?> pickImageFromGallery();
}

class PickerService implements BasePickerService {
  final Reader _read;

  const PickerService(this._read);

  ImagePicker get picker => _read(imagePickerProvider);

  @override
  Future<XFile?> pickImageFromGallery() async => await picker.pickImage(source: ImageSource.gallery);
}