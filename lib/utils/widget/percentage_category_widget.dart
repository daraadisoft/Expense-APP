import 'package:expense_app/features/add_expense/model/category_model.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

import 'image_loader.dart';

class PercentageCategoryWidget extends StatelessWidget {
  const PercentageCategoryWidget({super.key,required this.categoryModel,required this.totalAmount,});
  final CategoryModel categoryModel;
  final double totalAmount;
  @override
  Widget build(BuildContext context) {

    var percentage = ((categoryModel.amount!/ totalAmount) * 100).toStringAsFixed(2);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSize.defaultPadding / 2),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.decodeColor(
                  hex: categoryModel.color.toString())),
          child: ImageLoader(
            url: categoryModel.url.toString(),
            fit: BoxFit.cover,
            width: 32,
            height: 32,
            color: AppColor.white,
          ),
        ),
        const SizedBox(
          width: AppSize.defaultPadding,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    categoryModel.name.toString(),
                    style: AppTheme.getTextStyle(
                      color: AppColor.black.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(
                    width: AppSize.defaultPadding / 2,
                  ),
                  Text(
                    '$percentage%',
                    style: AppTheme.getTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${categoryModel.amount}',
                    style: AppTheme.getTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                color: AppColor.primaryColor,
                backgroundColor: AppColor.grey,
                value: categoryModel.amount!/ totalAmount,
                borderRadius: BorderRadius.circular(AppSize.defaultPadding),
              ),
              const SizedBox(
                height: AppSize.defaultPadding / 2,
              ),
              const Divider(
                color: AppColor.grey,
              )
            ],
          ),
        )
      ],
    );
  }
}
