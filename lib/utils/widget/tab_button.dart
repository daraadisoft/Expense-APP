import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  TabButton({super.key,required this.isActive,required this.title});
  bool isActive;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? AppColor.black : AppColor.primaryColor.withOpacity(0.5),
        border: Border.all(color: AppColor.black)
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultPadding/2 , vertical: AppSize.defaultPadding/3),
      alignment: Alignment.center,
      child: Text(
        title,
        style: AppTheme.getTextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isActive ? AppColor.primaryColor : AppColor.white
        ),
      ),
    );
  }
}
