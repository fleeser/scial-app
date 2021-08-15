import 'package:scial/enums/event_list_state_enum.dart';
import 'package:scial/models/event_model.dart';

class EventListModel {
  final EventListStateEnum state;
  final List<EventModel>? events;

  const EventListModel({
    required this.state,
    this.events
  });
}