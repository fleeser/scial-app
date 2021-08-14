import 'package:scial/enums/event_category_enum.dart';

extension EventCategoryEnumExtension on EventCategoryEnum {
  int get value {
    switch (this) {
      case EventCategoryEnum.PARTY: return 0;
      case EventCategoryEnum.SPORTS: return 1;
      case EventCategoryEnum.WATCH: return 2;
    }
  }

  String get emoji {
    switch (this) {
      case EventCategoryEnum.PARTY: return '🎉';
      case EventCategoryEnum.SPORTS: return '⚽';
      case EventCategoryEnum.WATCH: return '📺';
    }
  }
}

EventCategoryEnum categoryFromValue(int value) {
  switch (value) {
    case 0: return EventCategoryEnum.PARTY;
    case 1: return EventCategoryEnum.SPORTS;
    default: return EventCategoryEnum.WATCH;
  }
}