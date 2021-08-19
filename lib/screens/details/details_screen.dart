import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:scial/args/details_screen_args.dart';
import 'package:scial/extensions/event_category_extension.dart';
import 'package:scial/themes/custom_system_ui_overlay_styles.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {

  final DetailsScreenArgs args;

  const DetailsScreen({ 
    Key? key,
    required this.args
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: CustomSystemUiOverlayStyles.dark,
      child: Scaffold(
        backgroundColor: Palette.gray900,
        body: Stack(
          children: [
            EventImage(url: args.event.imageUrl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  hasBackButton: true,
                  color: Colors.transparent
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.0 - MediaQuery.of(context).padding.top - kToolbarHeight + 24.0,
                    left: 24.0,
                    right: 24.0
                  ),
                  child: Text(
                    args.event.title,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.gray100,
                      height: 1.6
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    left: 24.0,
                    right: 24.0
                  ),
                  child: Text(
                    args.event.placeName,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Palette.gray400,
                      height: 1.6
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    left: 24.0,
                    right: 24.0
                  ),
                  child: Text(
                    '${'category'.tr()}:   ${args.event.eventCategoryEnum.emoji}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Palette.gray400,
                      height: 1.6
                    )
                  ),
                )
              ]
            )
          ]
        )
      )
    );
  }
}

class EventImage extends StatelessWidget {

  final String? url;

  const EventImage({ 
    Key? key,
    final this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url != null ? CachedNetworkImage(
      imageUrl: url!,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.0,
        decoration: BoxDecoration(
          color: Palette.gray800,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover
          )
        )
      ),
      placeholder: (BuildContext context, String url) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.0,
        color: Palette.gray800
      ),
      errorWidget: (BuildContext context, String url, dynamic e) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.0,
        color: Palette.gray800
      )
    ) : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.0,
      color: Palette.gray800
    );
  }
}