import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:scial/themes/palette.dart';
import 'package:scial/providers/providers.dart';

class SearchBar extends ConsumerWidget {

  const SearchBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final PanelController panelController = watch(panelControllerProvider);
    final bool isOpen = watch(searchIsOpenProvider);
    final bool addFloatingActionButtonIsShown = watch(addFloatingActionButtonIsShownProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Palette.gray900,
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 24.0,
            color: Palette.gray400
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Container(
              height: kToolbarHeight - 10.0,
              child: TextField(
                onTap: () async {
                  if (panelController.isPanelOpen) await panelController.close();

                  if (addFloatingActionButtonIsShown) context.read(addFloatingActionButtonIsShownProvider.notifier).trigger();
                  if (panelController.isPanelShown) await panelController.hide();

                  if (!isOpen) context.read(searchIsOpenProvider.notifier).trigger();
                },
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();

                  if (isOpen) context.read(searchIsOpenProvider.notifier).trigger();

                  if (!panelController.isPanelShown) await panelController.show();
                  if (!addFloatingActionButtonIsShown) context.read(addFloatingActionButtonIsShownProvider.notifier).trigger();
                },
                onChanged: (String input) {
                  context.read(searchInputProvider.notifier).update(input);
                },
                autocorrect: false,
                autofocus: false,
                keyboardAppearance: Brightness.dark,
                decoration: InputDecoration(
                  hintText: 'search'.tr(),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    height: 1.0,
                    color: Palette.gray400
                  )
                ),
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.0,
                  color: Palette.gray100
                )
              )
            )
          )
        ]
      )
    );
  }
}