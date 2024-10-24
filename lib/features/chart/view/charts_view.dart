import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/chart/widget/graphic_widget.dart';
import 'package:expense_app/features/record/controller/record_controller.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/check_grid_count.dart';
import 'package:expense_app/utils/data/category_enum.dart';
import 'package:expense_app/utils/widget/custom_grid_view.dart';
import 'package:expense_app/utils/widget/no_records_widget.dart';
import 'package:expense_app/utils/widget/percentage_category_widget.dart';
import 'package:expense_app/utils/widget/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartsView extends StatefulWidget {
  @override
  State<ChartsView> createState() => _ChartsViewState();
}

class _ChartsViewState extends State<ChartsView> {
  RecordController recordController = RecordController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        recordController.isInChartView = true;
        recordController.init();
        return recordController;
      },
      child: Consumer<RecordController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100),
              child: AppBar(
                title: Text(
                  AppTranslateKey.charts.tr(),
                  style: AppTheme.getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white),
                ),
                flexibleSpace: Container(
                  height: 80,
                  margin:
                      const EdgeInsets.only(top: AppSize.defaultPadding * 3),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.defaultPadding * 2,
                      vertical: AppSize.defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(controller.headerType.length, (index) {
                      var data = controller.headerType[index];
                      return Expanded(
                        flex: index == 0 ? 4 : 7,
                        child: InkWell(
                          onTap: () async {
                            //click change expense
                            if (index == 0) {
                              controller.setNewType(index: index);
                              return;
                            }

                            //click change date
                            final DateTimeRange? datePicker =
                                await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 10),
                            );

                            if (datePicker != null) {
                              controller.setNewDate(date: datePicker);
                            }
                          },
                          child: TabButton(
                            isActive: index == 0,
                            title: data.title,
                            icon: Builder(builder: (context) {
                              if (index == 0) {
                                return Icon(
                                  data.key == CategoryEnum.expense
                                      ? Icons.arrow_drop_down_outlined
                                      : Icons.arrow_drop_up_outlined,
                                  color: AppColor.white,
                                );
                              }

                              return const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: AppColor.black,
                              );
                            }),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            body: Builder(
              builder: (context) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.getExpenseModel.dateExpense.isEmpty) {
                  return Center(child: NoRecordsWidget());
                }

                return CustomGridView(
                    shrinkWrap: true,
                    itemCount: 2,
                    crossAxisCount: CheckGridCount.checkGridCountChartView(context),
                    builder: (context, index) {
                      if(index==0){
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultPadding),
                          child: GraphicWidget(
                            listCategory: controller.getExpenseModel.pieChart,
                            totalAmount: controller.typeTransactionKey ==
                                CategoryEnum.expense
                                ? controller.getExpenseModel.totalExpense!
                                : controller.getExpenseModel.totalIncome!,
                            startDate: controller.startDateTime,
                            endDate: controller.endDateTime,
                          ),
                        );
                      }

                      //list down category
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(
                            color: AppColor.grey,
                          ),
                          const SizedBox(
                            height: AppSize.defaultPadding / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.defaultPadding),
                            child: CustomGridView(
                              shrinkWrap: true,
                              itemCount:
                                  controller.getExpenseModel.pieChart.length,
                              crossAxisCount:
                                  CheckGridCount.checkGridCountChartView(
                                      context),
                              builder: (context, subIndex) {
                                var data = controller
                                    .getExpenseModel.pieChart[subIndex];
                                return PercentageCategoryWidget(
                                  categoryModel: data,
                                  totalAmount: controller.typeTransactionKey ==
                                          CategoryEnum.expense
                                      ? controller.getExpenseModel.totalExpense!
                                      : controller.getExpenseModel.totalIncome!,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
