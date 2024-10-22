import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/controller/add_expense_controller.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_size.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/widget/tab_button.dart';
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
    return ChangeNotifierProvider(create: (context){
      addExpenseController.init();
      return addExpenseController;
    },
      child: Consumer<AddExpenseController>(
        builder: (context,controller,child){
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: (){
                  NavigationService.instance.pop();
                },
                child: const Icon(Icons.arrow_back_outlined),
              ),
              title: Text(AppTranslateKey.add.tr(),style: AppTheme.getTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white
              ),),
              bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.defaultPadding * 2,vertical: AppSize.defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.categoryType.length, (index){
                      var data = controller.categoryType[index];
                      return Expanded(
                        child: InkWell(
                          onTap: (){
                              controller.changeIndexType(data: index);
                            },
                          child: TabButton(isActive: controller.indexType == index, title: data.title),
                        ),
                      );
                    }),
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
