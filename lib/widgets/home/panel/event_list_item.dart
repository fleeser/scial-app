import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:scial/models/event_model.dart';
import 'package:scial/routes.dart';
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
      onPressed: () => Routes.navigateToDetailsScreen(event: event),
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Row(
        children: [
          event.imageUrl != null ? CachedNetworkImage(
            imageUrl: event.imageUrl!,
            imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Palette.gray800,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover
                )
              )
            ),
            placeholder: (BuildContext context, String url) => Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Palette.gray800
              )
            ),
            errorWidget: (BuildContext context, String url, dynamic e) => Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Palette.gray800
              )
            )
          ) : Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Palette.gray800
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