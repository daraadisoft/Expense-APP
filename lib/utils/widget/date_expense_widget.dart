import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/model/get_expense_model.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/date_helper.dart';
import 'package:expense_app/utils/widget/transaction_widget.dart';
import 'package:flutter/material.dart';

class DateExpenseWidget extends StatelessWidget {
  const DateExpenseWidget({super.key, required this.dateExpense});

  final DateExpense dateExpense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: AppSize.defaultPadding,
            ),
            Text(
              '${dateExpense.date.toString()} ${DateHelper.getDayName(date: dateExpense.date.toString())}',
              style: AppTheme.getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black.withOpacity(0.9)),
            ),
            const Spacer(),
            Visibility(
              visible: dateExpense.expense.toString() != '0.0',
              child: Text(
                '${AppTranslateKey.expense.tr()} : ${dateExpense.expense.toString()}',
                style: AppTheme.getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black.withOpacity(0.9)),
              ),
            ),
            SizedBox(
              width: dateExpense.income.toString() != '0.0'
                  ? AppSize.defaultPadding / 2
                  : 0,
            ),
            Visibility(
              visible: dateExpense.income.toString() != '0.0',
              child: Text(
                '${AppTranslateKey.income.tr()} : ${dateExpense.income.toString()}',
                style: AppTheme.getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black.withOpacity(0.9)),
              ),
            ),
            const SizedBox(
              width: AppSize.defaultPadding,
            ),
          ],
        ),
        const Divider(
          color: AppColor.black,
        ),
        const SizedBox(
          height: AppSize.defaultPadding,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSize.defaultPadding),
          child: ListView.builder(
              itemCount: dateExpense.transactions.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = dateExpense.transactions[index];
                return TransactionWidget(
                  transaction: data,
                  isShowDivider: index != dateExpense.transactions.length - 1,
                );
              }),
        )
      ],
    );
  }
}
