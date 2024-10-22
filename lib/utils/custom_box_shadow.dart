import 'package:flutter/material.dart';
import 'app_color.dart';

class CustomBoxShadow {
  static final List<BoxShadow> _customBoxShadowAuth = [
    BoxShadow(
      color: AppColor.black.withOpacity(0.3),
      blurRadius: 4,
    )
  ];

  static List<BoxShadow> get customBoxShadowAuth => _customBoxShadowAuth;
}
