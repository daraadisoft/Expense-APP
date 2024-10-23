import 'package:expense_app/utils/app_size.dart';
import 'package:flutter/cupertino.dart';

class CheckGridCount {
  static int checkGridCountCategory(BuildContext context) {
    if (MediaQuery.of(context).size.width > AppSize.desktopSize) {
      return 8;
    } else if (MediaQuery.of(context).size.width > AppSize.tabletSize) {
      return 6;
    } else {
      return 4;
    }
  }
}
