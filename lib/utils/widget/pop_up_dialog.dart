import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopUpDialog {
  static void showErrorDialog(
      {
      String message = '',
      Function()? onClick}) {
    showCupertinoDialog(
      context: NavigationService.instance.context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(AppTranslateKey.error.tr()),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                if (onClick != null) {
                  onClick();
                  return;
                }
                NavigationService.instance.pop();
              },
              child: Text(AppTranslateKey.ok.tr()),
            ),
          ],
        );
      },
    );
  }

  static void showLoadingDialog({String? message}) {
    showDialog(
        context: NavigationService.instance.context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 32,
                  height: 34,
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
                Text(message ?? AppTranslateKey.loading.tr()),
                const SizedBox(
                  height: AppSize.defaultPadding,
                ),
              ],
            ),
          );
        });
  }

  static void showSnackBarMessage(
      {required String message,
      Color backgroundColor = AppColor.primaryColor}) {
    ScaffoldMessenger.of(NavigationService.instance.context).hideCurrentSnackBar();

    Widget content = Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.defaultPadding)),
      constraints: const BoxConstraints(
          maxWidth: AppSize.widthOfFormAuth, minHeight: 60),
      child: Text(message),
    );

    final snackBar = SnackBar(
      content: Container(
          constraints: const BoxConstraints(maxWidth: AppSize.widthOfFormAuth),
          child: content),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(NavigationService.instance.context).showSnackBar(snackBar);
  }
}
