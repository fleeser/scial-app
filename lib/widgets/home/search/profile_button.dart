import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/providers/providers.dart';
import 'package:scial/routes.dart';
import 'package:scial/themes/palette.dart';

class ProfileButton extends ConsumerWidget {

  const ProfileButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final AsyncValue<String?> image = watch(userImageProvider);

    return SizedBox(
      height: kToolbarHeight - 10.0,
      width: kToolbarHeight - 10.0,
      child: RawMaterialButton(
        onPressed: () => Routes.navigateToProfileScreen(),
        fillColor: Palette.gray900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: image.when(
          data: (String? image) => image != null ? ImageWidget(url: image) : null, 
          loading: () => null, 
          error: (Object e, StackTrace? s) => null
        )
      )
    );
  }
}

class ImageWidget extends StatelessWidget {

  final String url;

  const ImageWidget({ 
    Key? key,
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
        height: kToolbarHeight - 10.0,
        width: kToolbarHeight - 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Palette.gray900,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover
          )
        )
      ),
      placeholder: (BuildContext context, String url) => Container(
        height: kToolbarHeight - 10.0,
        width: kToolbarHeight - 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Palette.gray900
        )
      ),
      errorWidget: (BuildContext context, String url, dynamic e) => Container(
        height: kToolbarHeight - 10.0,
        width: kToolbarHeight - 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Palette.gray900
        )
      )
    );
  }
}