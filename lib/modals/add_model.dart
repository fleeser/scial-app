import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/enums/event_category_enum.dart';
import 'package:scial/extensions/event_category_extension.dart';
import 'package:scial/models/event_model.dart';
import 'package:scial/models/search_model.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/routes.dart';
import 'package:scial/services/database_service.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/custom_text_field.dart';
import 'package:scial/widgets/default_button.dart';
import 'package:scial/widgets/dropdown/custom_dropdown.dart';
import 'package:scial/widgets/search/search_menu.dart';

class AddModal extends ConsumerWidget {

  const AddModal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final int? selectedCategory = watch(selectedCategoryProvider);
    final SearchModel? searchModel = watch(searchModelProvider);
    final bool isLoading = watch(createEventIsLoadingProvider);
    final DatabaseService databaseService = watch(databaseServiceProvider);
    final String titleText = watch(titleTextProvider);
    final String whereText = watch(whereTextProvider);
    final TextEditingController titleController = watch(titleControllerProvider);
    final TextEditingController whereController = watch(whereControllerProvider);

    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.0,
          color: Palette.blue500
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
          child: CustomTextField(
            icon: Icons.title_rounded,
            controller: titleController,
            onChanged: (String text) => context.read(titleTextProvider.notifier).update(text),
            hintText: 'title'.tr()
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
          child: CustomDropdown(
            provider: categorySelectorIsOpenProvider,
            onItemPressed: (int index) => context.read(selectedCategoryProvider.notifier).update(index),
            items: allCategories.map((EventCategoryEnum eventCategoryEnum) => '${eventCategoryEnum.emoji}   ${eventCategoryEnum.name}').toList(),
            title: selectedCategory == null ? '${'category'.tr()}:' : '${'category'.tr()}:   ${categoryFromValue(selectedCategory).emoji}   ${categoryFromValue(selectedCategory).name}'
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
          child: SearchMenu(
            hintText: searchModel == null ? '${'where'.tr()}?' : searchModel.name,
            controller: whereController,
            onChanged: (String text) => context.read(whereTextProvider.notifier).update(text),
            input: whereText,
            onItemPressed: (SearchModel searchModel) {
              context.read(searchModelProvider.notifier).update(searchModel);
              context.read(whereTextProvider.notifier).update("");
              whereController.clear();
              FocusScope.of(context).unfocus();
            }
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
          child: DefaultButton(
            onPressed: () async {
              context.read(createEventIsLoadingProvider.notifier).trigger();

              bool success = await databaseService.addEvent(
                EventModel(
                  title: titleText,
                  placeName: searchModel!.name,
                  eventCategoryEnum: categoryFromValue(selectedCategory!),
                  latitude: searchModel.latitude,
                  longitude: searchModel.longitude
                )
              );

              context.read(createEventIsLoadingProvider.notifier).trigger();

              if (success) {
                Routes.navigateBack();
              }
            },
            text: 'create_event'.tr(),
            isLoading: isLoading
          ),
        )
      ]
    );
  }
}