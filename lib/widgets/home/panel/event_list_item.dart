import 'package:flutter/material.dart';

import 'package:scial/models/event_model.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/extensions/event_category_extension.dart';

class EventListItem extends StatelessWidget {

  final EventModel event;

  const EventListItem({ 
    Key? key,
    required this.event
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: Palette.gray800,
              borderRadius: BorderRadius.circular(12.0)
            )
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Palette.gray100,
                    height: 1.0
                  )
                ),
                SizedBox(height: 10.0),
                Text(
                  event.eventCategoryEnum.emoji,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Palette.gray400,
                    height: 1.0
                  )
                )
              ]
            )
          ),
          SizedBox(width: 24.0),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Palette.gray400,
            size: 18.0
          )
        ]
      )
    );
  }
}