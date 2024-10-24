import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class HeaderRecordsWidget extends StatelessWidget {
  const HeaderRecordsWidget({super.key,required this.header,required this.value});
  final String header;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header,style: AppTheme.getTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColor.white.withOpacity(0.9),
        ),),
        const SizedBox(
          height: AppSize.defaultPadding / 2,
        ),
        Text(value,style: AppTheme.getTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),),
        const SizedBox(
          height: AppSize.defaultPadding / 2,
        ),
      ],
    );
  }
}

