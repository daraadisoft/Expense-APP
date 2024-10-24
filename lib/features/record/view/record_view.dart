import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/view/add_expense_view.dart';
import 'package:expense_app/features/record/controller/record_controller.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/check_grid_count.dart';
import 'package:expense_app/utils/date_helper.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/widget/custom_grid_view.dart';
import 'package:expense_app/utils/widget/date_expense_widget.dart';
import 'package:expense_app/utils/widget/header_records_widget.dart';
import 'package:expense_app/utils/widget/no_records_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordView extends StatefulWidget {
  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  RecordController recordController = RecordController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        recordController.init();
        return recordController;
      },
      child: Consumer<RecordController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 140),
              child: AppBar(
                title: Text(
                  AppTranslateKey.records.tr(),
                  style: AppTheme.getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white),
                ),
                actions: [
                  InkWell(
                    onTap: () async {
                      final DateTimeRange? datePicker = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 10),
                      );

                      if (datePicker != null) {
                        controller.setNewDate(date: datePicker);
                      }
                    },
                    child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSize.defaultPadding,
                            vertical: AppSize.defaultPadding),
                        child: Icon(Icons.calendar_month_outlined)),
                  ),
                ],
                flexibleSpace: Container(
                  height: 100,
                  margin:
                      const EdgeInsets.only(top: AppSize.defaultPadding * 3),
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSize.defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HeaderRecordsWidget(header: controller.dateDisplay, value: AppTranslateKey.date.tr()),
                      HeaderRecordsWidget(header: AppTranslateKey.expenses.tr(), value: controller.getExpenseModel.totalExpense.toString()),
                      HeaderRecordsWidget(header: AppTranslateKey.income.toString(), value: controller.getExpenseModel.totalIncome.toString()),
                      HeaderRecordsWidget(header: AppTranslateKey.balance.toString(), value: controller.getExpenseModel.balance.toString()),
                    ]
                  ),
                ),
              ),
            ),

            body: Builder(
              builder: (context){

                if(controller.isLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if(controller.getExpenseModel.dateExpense.isEmpty){

                  return Center(child: NoRecordsWidget());

                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
                  child: CustomGridView(
                    itemCount: controller.getExpenseModel.dateExpense.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    crossAxisCount: CheckGridCount.checkGridCountRecordView(context),
                    builder: (context,index){
                      var data = controller.getExpenseModel.dateExpense[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
                        child: DateExpenseWidget(
                          dateExpense: data,
                        ),
                      );
                    },
                  ),
                );

              },
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                var map = await NavigationService.instance.push(const AddExpenseView());

                if(map['isAddRecord']){

                  var addRecordDate = DateHelper.getDate(date: map['date']);

                  DateTimeRange newDateTimeRange = DateTimeRange(
                    start: addRecordDate.millisecondsSinceEpoch < controller.startDateTime.millisecondsSinceEpoch ? addRecordDate : controller.startDateTime,
                    end: addRecordDate.millisecondsSinceEpoch > controller.endDateTime.millisecondsSinceEpoch ? addRecordDate : controller.endDateTime
                  );


                  controller.setNewDate(date: newDateTimeRange);

                }

              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
