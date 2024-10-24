import 'package:expense_app/features/add_expense/model/get_expense_model.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/data/category_enum.dart';
import 'package:expense_app/utils/widget/image_loader.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key, required this.transaction,required this.isShowDivider});

  final Transaction transaction;

  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSize.defaultPadding / 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.decodeColor(
                      hex: transaction.categoryModel.color.toString())),
              child: ImageLoader(
                url: transaction.categoryModel.url.toString(),
                fit: BoxFit.cover,
                width: 32,
                height: 32,
                color: AppColor.white,
              ),
            ),
            const SizedBox(
              width: AppSize.defaultPadding,
            ),
            Text(
              transaction.categoryModel.name.toString(),
              style: AppTheme.getTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColor.black.withOpacity(0.9)),
            ),
            const Spacer(),
            Text(
                '${transaction.amount! * (transaction.type == CategoryEnum.income ? 1 : -1)}',
              style: AppTheme.getTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColor.black.withOpacity(0.9))
            )
          ],
        ),
        Visibility(
          visible: isShowDivider,
          child: const Divider(
            color: AppColor.grey,
          ),
        )
      ],
    );
  }
}
