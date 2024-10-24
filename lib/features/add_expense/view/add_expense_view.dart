import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/controller/add_expense_controller.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/check_grid_count.dart';
import 'package:expense_app/utils/date_helper.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/widget/category_icon_widget.dart';
import 'package:expense_app/utils/widget/custom_button.dart';
import 'package:expense_app/utils/widget/custom_grid_view.dart';
import 'package:expense_app/utils/widget/tab_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  AddExpenseController addExpenseController = AddExpenseController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        addExpenseController.init();
        return addExpenseController;
      },
      child: Consumer<AddExpenseController>(
        builder: (context, controller, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 100),
              child: AppBar(
                leading: InkWell(
                  onTap: () {
                    NavigationService.instance.pop(result: {
                      'isAddRecord': controller.isAddRecord,
                      'date': controller.date ?? '${DateTime.now().day}-${DateHelper.getMonthName(month: DateTime.now().month)}-${DateTime.now().year}'
                    });
                  },
                  child: const Icon(Icons.arrow_back_outlined),
                ),
                title: Text(
                  AppTranslateKey.add.tr(),
                  style: AppTheme.getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white),
                ),
                actions: [
                  InkWell(
                    onTap: () async {
                      final DateTime? datePicker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 10),
                      );

                      if (datePicker != null) {
                        controller.setDate(
                            data: DateFormat('dd-MMM-yyyy').format(datePicker));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.defaultPadding,
                          vertical: AppSize.defaultPadding),
                      child: Builder(builder: (context) {
                        if (controller.date != null) {
                          return Text(
                            controller.date.toString(),
                            style: AppTheme.getTextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColor.white),
                          );
                        }
                        return const Icon(Icons.calendar_month_outlined);
                      }),
                    ),
                  )
                ],
                flexibleSpace: Container(
                  height: 80,
                  margin:
                      const EdgeInsets.only(top: AppSize.defaultPadding * (kIsWeb ? 3 : 5)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.defaultPadding * 2,
                      vertical: AppSize.defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(controller.categoryType.length, (index) {
                      var data = controller.categoryType[index];
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.changeIndexType(data: index);
                          },
                          child: TabButton(
                              isActive: controller.indexType == index,
                              title: data.title),
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
                  return const Center(child: CircularProgressIndicator());
                }

                return Container(
                  margin: const EdgeInsets.only(top: AppSize.defaultPadding),
                  child: CustomGridView(
                    itemCount: controller.indexType == 0
                        ? controller.listExpenseType.length
                        : controller.listIncomeType.length,
                    shrinkWrap: true,
                    crossAxisCount:
                        CheckGridCount.checkGridCountCategory(context),
                    builder: (context, index) {
                      var data = controller.indexType == 0
                          ? controller.listExpenseType[index]
                          : controller.listIncomeType[index];
                      return InkWell(
                          onTap: () {
                            controller.changeIndexCategory(data: index);
                          },
                          child: CategoryIconWidget(
                              imageURL: data.url.toString(),
                              name: data.name.toString(),
                              isActive: index == controller.indexCategory));
                    },
                  ),
                );
              },
            ),
            bottomSheet: Visibility(
              visible: controller.indexCategory != -1,
              child: Container(
                margin: const EdgeInsets.all(AppSize.defaultPadding),
                constraints: const BoxConstraints(
                  maxWidth: AppSize.widthOfFormAuth,
                ),
                child: Form(
                  key: controller.keyForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: controller.amountController,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.isEmpty) return '';
                          return null;
                        },
                        onChanged: (v) {
                          setState(() {
                            controller.keyForm.currentState!.validate();
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          fillColor: AppColor.grey.withOpacity(0.5),
                          labelText: AppTranslateKey.amount.tr(),
                          prefixIcon:
                              const Icon(Icons.monetization_on_outlined),
                          constraints: const BoxConstraints(
                            maxWidth: AppSize.widthOfFormAuth,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.defaultPadding / 2,
                      ),
                      TextFormField(
                        controller: controller.noteController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: AppColor.white,
                          labelText: AppTranslateKey.enterANote.tr(),
                          prefixIcon: const Icon(Icons.note_add_outlined),
                          constraints: const BoxConstraints(
                            maxWidth: AppSize.widthOfFormAuth,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.defaultPadding / 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                                onPressed: controller.isValidateForm()
                                    ? () {
                                        controller.createExpense();
                                      }
                                    : null,
                                child: Text(
                                  AppTranslateKey.save.tr(),
                                  style: AppTheme.getTextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.white),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
