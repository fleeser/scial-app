import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:scial/themes/palette.dart';

class CustomSystemUiOverlayStyles {
  
  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Palette.gray900
  );
}