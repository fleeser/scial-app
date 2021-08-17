import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:scial/providers/providers.dart';
import 'package:scial/services/picker_service.dart';
import 'package:scial/themes/palette.dart';

class FileImageWidget extends ConsumerWidget {

  const FileImageWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final File? selectedFile = watch(selectedFileProvider);
    final PickerService pickerService = watch(pickerServiceProvider);
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.0,
      child: RawMaterialButton(
        onPressed: () async {
          if (selectedFile == null) {
            XFile? file = await pickerService.pickImageFromGallery();

            if (file != null) {
              context.read(selectedFileProvider.notifier).update(File(file.path));
            }
          } else {
            print("Choose wether to pick or delete");
          }
        },
        fillColor: Palette.gray800,
        child: selectedFile != null ? ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Image.file(
            File(selectedFile.path),
            fit: BoxFit.cover
          )
        ) : Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'press_to_pick_image'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Palette.gray100,
              height: 1.6
            )
          )
        )
      )
    );
  }
}