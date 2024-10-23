import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/widget/image_loader.dart';
import 'package:flutter/material.dart';

class CategoryIconWidget extends StatelessWidget {
  const CategoryIconWidget(
      {required this.imageURL, required this.name, required this.isActive});

  final String imageURL;
  final String name;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSize.defaultPadding),
          decoration: BoxDecoration(
              color: isActive ? AppColor.primaryColor : AppColor.grey,
              shape: BoxShape.circle),
          child: ImageLoader(
            url: imageURL,
            fit: BoxFit.cover,
            width: 32,
            height: 32,
            color: AppColor.white,
          ),
        ),
        const SizedBox(
          height: AppSize.defaultPadding / 2,
        ),
        Text(
          name,
          style: AppTheme.getTextStyle(
              fontWeight: FontWeight.w400, fontSize: 14, color: AppColor.black),
        )
      ],
    );
  }
}
