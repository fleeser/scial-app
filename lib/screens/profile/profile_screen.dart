import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import 'package:scial/extensions/event_category_extension.dart';
import 'package:scial/modals/choose_image_action_modal.dart';
import 'package:scial/modals/upload_image_modal.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/models/user_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/routes.dart';
import 'package:scial/services/picker_service.dart';
import 'package:scial/themes/custom_system_ui_overlay_styles.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_app_bar.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';

class ProfileScreen extends ConsumerWidget {

  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<UserModel?> userModel = watch(userModelProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: CustomSystemUiOverlayStyles.dark,
      child: Scaffold(
        backgroundColor: Palette.gray900,
        body: Column(
          children: [
            CustomAppBar(
              hasBackButton: true,
              title: 'profile'.tr()
            ),
            Expanded(
              child: userModel.when(
                data: (UserModel? user) => UserData(user: user), 
                loading: () => Center(
                  child: CustomLoadingIndicator(size: 16.0, color: Palette.gray100),
                ), 
                error: (Object e, StackTrace? s) => ErrorWidget()
              )
            )
          ]
        )
      )
    );
  }
}

class UserData extends StatelessWidget {

  final UserModel? user;

  const UserData({ 
    Key? key,
    this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 24.0),
          child: ProfileImage(url: user?.imageUrl)
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Text(
            'my_events'.tr(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Palette.gray100,
              height: 1.0
            )
          )
        ),
        SizedBox(height: 24.0),
        Expanded(
          child: EventsList()
        )
      ]
    );
  }
}

class EventsList extends ConsumerWidget {

  const EventsList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<List<EventModel>> events = watch(usersEventsProvider);

    return events.when(
      data: (List<EventModel> events) => events.length == 0 ? Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'no_my_events'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              height: 1.6,
              color: Palette.gray400
            )
          )
        )
      ) : ListView.builder(
        itemCount: events.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return EventlistItem(event: events[index]);
        }
      ), 
      loading: () => Center(
        child: CustomLoadingIndicator(size: 16.0, color: Palette.gray100),
      ), 
      error: (Object e, StackTrace? s) => ErrorWidget()
    );
  }
}

class EventlistItem extends StatelessWidget {

  final EventModel event;

  const EventlistItem({ 
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

class ProfileImage extends ConsumerWidget {

  final String? url;

  const ProfileImage({ 
    Key? key,
    this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final PickerService pickerService = watch(pickerServiceProvider);
    
    return SizedBox(
      width: 80.0,
      height: 80.0,
      child: RawMaterialButton(
        onPressed: () async {
          if (url != null) {
            await showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 24.0,
                    left: 24.0,
                    right: 24.0
                  ),
                  child: ChooseImageActionModal(
                    onChangePressed: () {},
                    onRemovePressed: () {}
                  )
                );
              }
            );
          } else {
            pickNewImage(context: context, pickerService: pickerService);
          }
        },
        fillColor: Palette.gray800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        child: url != null ? CachedNetworkImage(
          imageUrl: url!,
          imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Palette.gray800,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover
              )
            )
          ),
          placeholder: (BuildContext context, String url) => Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Palette.gray800
            )
          ),
          errorWidget: (BuildContext context, String url, dynamic e) => Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Palette.gray800
            )
          )
        ) : null
      )
    );
  }
}

class ErrorWidget extends StatelessWidget {

  const ErrorWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
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
    );
  }
}

void pickNewImage({ required BuildContext context, required PickerService pickerService }) async {
  XFile? file = await pickerService.pickImageFromGallery();

  if (file != null) {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 24.0,
            left: 24.0,
            right: 24.0
          ),
          child: UploadImageModal(file: File(file.path))
        );
      }
    );
  }
}