import 'package:scial/enums/child_enum.dart';

extension ChildExtension on ChildEnum {
  String get childRef {
    switch (this) {
      case ChildEnum.EVENT_IMAGES: return 'event-images';
    }
  }
}