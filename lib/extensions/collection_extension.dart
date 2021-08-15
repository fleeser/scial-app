import 'package:scial/enums/collection_enum.dart';

extension CollectionExtension on CollectionEnum {
  String get ref {
    switch (this) {
      case CollectionEnum.USERS: return 'users';
      case CollectionEnum.EVENTS: return 'events';
    }
  }
}