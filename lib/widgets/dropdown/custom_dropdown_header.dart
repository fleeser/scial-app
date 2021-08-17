import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:scial/providers/provider_classes.dart';
import 'package:scial/themes/palette.dart';

class CustomDropdownHeader extends ConsumerWidget {

  final StateNotifierProvider<BooleanStartingWithFalseStateNotifier, bool> provider;
  final String title;

  const CustomDropdownHeader({ 
    Key? key,
    required this.provider,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final bool isOpen = watch(provider);

    return SizedBox(
      height: 52.0,
      width: MediaQuery.of(context).size.width - 24.0 - 24.0,
      child: RawMaterialButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          context.read(provider.notifier).trigger();
        },
        fillColor: Palette.gray800,
        shape: RoundedRectangleBorder(borderRadius: isOpen ? BorderRadius.vertical(top: Radius.circular(12.0)) : BorderRadius.circular(12.0)),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Palette.gray100,
                  height: 1.0
                )
              )
            ),
            SizedBox(width: 24.0),
            Icon(
              isOpen ? Icons.expand_less_rounded : Icons.expand_more_rounded,
              color: Palette.gray400,
              size: 26.0
            )
          ]
        )
      )
    );
  }
}