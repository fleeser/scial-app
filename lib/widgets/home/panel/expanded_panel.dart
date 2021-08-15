import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_search/mapbox_search.dart';

import 'package:scial/enums/event_list_state_enum.dart';
import 'package:scial/enums/selected_center_enum.dart';
import 'package:scial/models/event_list_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';
import 'package:scial/widgets/home/panel/event_list.dart';
import 'package:scial/widgets/home/panel/panel_dragger.dart';

class ExpandedPanel extends ConsumerWidget {

  const ExpandedPanel({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<EventListModel> events = watch(eventsWithinStreamProvider);
    final SelectedCenterEnum selectedCenter = watch(selectedCenterProvider);
    final MapBoxPlace? selectedPlace = watch(selectedPlaceProvider);

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
                      selectedCenter == SelectedCenterEnum.LOCATION ? 'my_location'.tr() : selectedPlace!.placeName,
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
              data: (EventListModel events) {
                switch(events.state) {
                  case EventListStateEnum.WAITING: return LoadingEvents();
                  case EventListStateEnum.DENIED: return LocationDenied();
                  case EventListStateEnum.FAIL: return LocationFailed();
                  case EventListStateEnum.SUCCESS: return events.events!.length == 0 ? NoEventsFound() : EventList(events: events.events!); 
                }
              },
              loading: () => LoadingEvents(), 
              error: (Object e, StackTrace? s) => LoadingError()
            )
          )
        ]
      )
    );
  }
}

class LoadingEvents extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomLoadingIndicator(size: 16.0, color: Palette.gray100),
    );
  }
}

// TODO: Loaction denied for ever

class LocationDenied extends StatelessWidget {
  const LocationDenied({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        'location_denied'.tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          color: Palette.gray400,
          height: 1.6
        )
      )
    );
  }
}

class LocationFailed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        'location_fail'.tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          color: Palette.gray400,
          height: 1.6
        )
      )
    );
  }
}

class LoadingError extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class NoEventsFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}