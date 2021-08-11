import 'package:flutter/material.dart';

bool fitsOnScreen(BuildContext context, double widgetsHeight, { bool hasAppBar = false }) => MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - (hasAppBar ? kToolbarHeight + MediaQuery.of(context).padding.top : 0.0) - widgetsHeight >= 0.0;