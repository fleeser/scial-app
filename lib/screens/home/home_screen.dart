import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:scial/widgets/home/map/custom_map.dart';
import 'package:scial/widgets/home/add/add_floating_action_button.dart';
import 'package:scial/widgets/home/search/search_widget.dart';
import 'package:scial/themes/custom_system_ui_overlay_styles.dart';
import 'package:scial/themes/palette.dart';
import 'package:scial/widgets/home/panel/collapsed_panel.dart';
import 'package:scial/helpers.dart';
import 'package:scial/providers/providers.dart';
import 'package:scial/widgets/home/panel/expanded_panel.dart';

class HomeScreen extends ConsumerWidget {

  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final double textHeight = getTextHeight('${'panel_drag_up'.tr()}!   🎉', TextStyle(fontSize: 14.0, color: Palette.gray100, height: 1.6), MediaQuery.of(context).size.width - 24.0 - 24.0);
    final double panelMinHeight = 24.0 + 6.0 + 24.0 + textHeight + 24.0 + MediaQuery.of(context).padding.bottom;
    final double panelMaxHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - 24.0 - (kToolbarHeight - 10.0) - 24.0;
    final double addEventFloatingActionButtonPositionClosed = panelMinHeight + 24.0;

    final bool addFloatingActionButtonIsShown = watch(addFloatingActionButtonIsShownProvider);
    final double addFloatingActionButtonPosition = watch(addFloatingActionButtonPositionProvider(addEventFloatingActionButtonPositionClosed));
    final PanelController panelController = watch(panelControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: CustomSystemUiOverlayStyles.dark,
      child: Scaffold(
        backgroundColor: Palette.gray900,
        body: Stack(
          children: [
            SlidingUpPanel(
              controller: panelController,
              parallaxEnabled: true,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              minHeight: panelMinHeight,
              maxHeight: panelMaxHeight,
              onPanelSlide: (double position) {
                context.read(addFloatingActionButtonPositionProvider(addEventFloatingActionButtonPositionClosed).notifier).changeTo(position * (panelMaxHeight - panelMinHeight) + addEventFloatingActionButtonPositionClosed);
              },
              body: CustomMap(),
              collapsed: CollapsedPanel(),
              panel: ExpandedPanel()
            ),
            addFloatingActionButtonIsShown ? Positioned(
              right: 24.0,
              bottom: addFloatingActionButtonPosition,
              child: AddFloatingActionButton()
            ) : Container(),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5.0, left: 24.0, right: 24.0),
              child: SearchWidget()
            )
          ]
        )
      )
    );
  }
}