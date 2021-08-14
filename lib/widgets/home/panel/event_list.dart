import 'package:flutter/material.dart';
import 'package:scial/models/event_model.dart';

import 'package:scial/widgets/home/panel/event_list_item.dart';

class EventList extends StatelessWidget {

  final List<EventModel> events;

  const EventList({ 
    Key? key,
    required this.events
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return EventListItem(event: events[index]);
      }
    );
  }
}