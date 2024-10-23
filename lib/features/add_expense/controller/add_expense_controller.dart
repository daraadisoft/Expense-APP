import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/model/add_expense_model.dart';
import 'package:expense_app/features/add_expense/model/category_model.dart';
import 'package:expense_app/repo/category_repository.dart';
import 'package:expense_app/repo/expense_repository.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/data/category_enum.dart';
import 'package:expense_app/utils/data/category_type.dart';
import 'package:expense_app/utils/navigation_service.dart';
import 'package:expense_app/utils/widget/pop_up_dialog.dart';
import 'package:flutter/cupertino.dart';

class AddExpenseController extends BaseController {
  @override
  Future<void> init() async {
    super.init();
    getListCategory();
  }

  final keyForm = GlobalKey<FormState>();

  int indexType = 0;

  bool isLoading = false;

  int indexCategory = -1;

  bool isAddRecord = false;

  List<CategoryType> categoryType = [
    CategoryType(
        title: AppTranslateKey.expense.tr(), key: CategoryEnum.expense),
    CategoryType(title: AppTranslateKey.income.tr(), key: CategoryEnum.income)
  ];

  List<CategoryModel> listExpenseType = [];

  List<CategoryModel> listIncomeType = [];

  TextEditingController amountController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  String? date;

  void changeIndexType({required int data}) {
    indexType = data;
    indexCategory = -1;
    notifyListeners();
  }

  void changeIndexCategory({required int data}) {
    indexCategory = data;
    notifyListeners();
  }

  bool isValidateForm() {
    if (keyForm.currentState == null) return false;
    return keyForm.currentState!.validate();
  }

  void getListCategory() async {
    isLoading = true;
    notifyListeners();

    var data = await CategoryRepository.instance.getCategory();

    for (CategoryModel item in data.data ?? []) {
      item.type == CategoryEnum.income
          ? listIncomeType.add(item)
          : listExpenseType.add(item);
    }

    isLoading = false;
    notifyListeners();
  }

  void createExpense() async {
    try {
      PopUpDialog.showLoadingDialog();
      var data = await ExpenseRepository.instance.createExpense(
          addExpenseModel: AddExpenseModel(
              date: date == null
                  ? DateFormat('dd-MMM-yyyy').format(DateTime.now())
                  : date.toString(),
              amount: double.tryParse(amountController.text.toString()) ?? 0,
              categoryID: indexType == 0
                  ? listExpenseType[indexCategory].id.toString()
                  : listIncomeType[indexCategory].id.toString(),
              note: noteController.text));

      NavigationService.instance.pop();
      isAddRecord = data.success;
      if (!data.success) {
        PopUpDialog.showErrorDialog(message: data.message);
        return;
      }

      amountController.text = '';
      noteController.text = '';
      notifyListeners();
    } catch (e) {
      NavigationService.instance.pop();
      PopUpDialog.showErrorDialog(message: e.toString());
    }
  }

  void setDate({required String data}) {
    date = data;
    notifyListeners();
  }
}
