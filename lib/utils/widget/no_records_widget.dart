import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:flutter/material.dart';

class NoRecordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.receipt_long_outlined,
          size: 128,
        ),
        const SizedBox(
          height: AppSize.defaultPadding,
        ),
        Text(
          AppTranslateKey.noRecords.tr(),
          style: AppTheme.getTextStyle(
              fontWeight: FontWeight.w600, fontSize: 22, color: AppColor.black),
        )
      ],
    );
  }
}
