import 'dart:io';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:scial/providers/providers.dart';
import 'package:scial/routes.dart';
import 'package:scial/services/database_service.dart';
import 'package:scial/services/picker_service.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_loading_indicator.dart';

class UploadImageModal extends ConsumerWidget {

  final File file;

  const UploadImageModal({ 
    Key? key,
    required this.file
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final isLoading = watch(uploadIsLoadingProvider);
    final newFile = watch(selectedImageProvider(file));
    final PickerService pickerService = watch(pickerServiceProvider);
    final DatabaseService databaseService = watch(databaseServiceProvider);
    
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Palette.gray900,
              borderRadius: BorderRadius.circular(12.0)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25.0 + 24.0, left: 24.0, right: 24.0),
                  child: Text(
                    '${'upload_new_image_sure'.tr()}?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Palette.gray100,
                      height: 1.6
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                  child: isLoading ? CustomLoadingIndicator(size: 16.0, color: Palette.gray100) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RawMaterialButton(
                        onPressed: () async {
                          XFile? pickedFile = await pickerService.pickImageFromGallery();
                          
                          if (pickedFile != null) context.read(selectedImageProvider(newFile).notifier).update(File(pickedFile.path));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                        fillColor: Palette.gray800,
                        child: Text(
                          'change'.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Palette.gray100,
                            height: 1.0
                          )
                        )
                      ),
                      SizedBox(width: 24.0),
                      RawMaterialButton(
                        onPressed: () async {
                          context.read(uploadIsLoadingProvider.notifier).trigger();

                          bool success = await databaseService.uploadPhoto(file: newFile);

                          if (success) {
                            Routes.navigateBack();
                          }

                          context.read(uploadIsLoadingProvider.notifier).trigger();
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                        fillColor: Palette.blue500,
                        child: Text(
                          'upload'.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Palette.white,
                            height: 1.0
                          )
                        )
                      )
                    ]
                  )
                ),
                SizedBox(height: 24.0)
              ]
            )
          )
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Image.file(
            newFile,
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover
          )
        )
      ]
    );
  }
}