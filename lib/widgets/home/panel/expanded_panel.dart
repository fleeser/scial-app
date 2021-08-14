import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/models/event_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';
import 'package:scial/widgets/home/panel/event_list.dart';
import 'package:scial/widgets/home/panel/panel_dragger.dart';

class ExpandedPanel extends ConsumerWidget {

  const ExpandedPanel({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<List<EventModel>> events = watch(eventsWithinStreamProvider);

    return Container(
      padding: EdgeInsets.only(top: 24.0),
      decoration: BoxDecoration(
        color: Palette.gray900,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))
      ),
      child: Column(
        children: [
          PanelDragger(),
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Text(
                    '${'search_here'.tr()}:',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.gray100,
                      height: 1.0
                    )
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'my_location'.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Palette.gray100,
                        height: 1.0
                      )
                    )
                  )
                ]
              )
            )
          ),
          SizedBox(height: 24.0),
          Expanded(
            child: events.when(
              data: (List<EventModel> eventsList) => eventsList.length > 0 ? EventList(events: eventsList) : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'no_events_found'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Palette.gray400,
                      height: 1.6
                    )
                  )
                )
              ),
              loading: () => Center(
                child: CustomLoadingIndicator(size: 16.0, color: Palette.gray100),
              ), 
              error: (Object e, StackTrace? s) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'error_loading'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Palette.gray400,
                    height: 1.6
                  )
                )
              )
            )
          )
        ]
      )
    );
  }
}