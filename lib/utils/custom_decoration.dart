import 'package:expense_app/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_size.dart';
import 'custom_box_shadow.dart';

class CustomDecoration {
  static BoxDecoration? customBoxDecorationAuth(
      {required BuildContext context,
      Color color = AppColor.white,
      double borderRadius = AppSize.defaultPadding}) {
    if (MediaQuery.of(context).size.width < AppSize.tabletSize) {
      return null;
    }

    return BoxDecoration(
        color: color,
        boxShadow: CustomBoxShadow.customBoxShadowAuth,
        borderRadius: BorderRadius.circular(AppSize.defaultPadding));
  }
}
