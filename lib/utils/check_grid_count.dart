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

  static int checkGridCountRecordView(BuildContext context){
    if (MediaQuery.of(context).size.width > AppSize.desktopSize) {
      return 3;
    } else if (MediaQuery.of(context).size.width > AppSize.tabletSize) {
      return 2;
    } else {
      return 1;
    }
  }

  static int checkGridCountChartView(BuildContext context){
    if (MediaQuery.of(context).size.width > AppSize.desktopSize) {
      return 2;
    } else {
      return 1;
    }
  }
}
