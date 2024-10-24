import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/model/get_expense_model.dart';
import 'package:expense_app/repo/expense_repository.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/data/category_enum.dart';
import 'package:expense_app/utils/data/category_type.dart';
import 'package:expense_app/utils/data/direction_enum.dart';
import 'package:expense_app/utils/data/query_helper.dart';
import 'package:expense_app/utils/date_helper.dart';
import 'package:expense_app/utils/widget/pop_up_dialog.dart';
import 'package:flutter/material.dart';

class RecordController extends BaseController {
  bool isLoading = false;

  GetExpenseModel getExpenseModel = GetExpenseModel();

  DateTime startDateTime = DateTime.now();

  DateTime endDateTime = DateTime.now();

  String dateDisplay = '';

  String typeTransactionTitle = AppTranslateKey.expenses.tr();

  String typeTransactionKey = CategoryEnum.expense;

  String direction = DirectionEnum.desc;

  List<CategoryType> headerType = [];

  bool isInChartView = false;

  @override
  Future init() async {
    super.init();
    getExpense();
  }

  void getExpense() async {
    isLoading = true;
    notifyListeners();
    String startDate =
        '${startDateTime == endDateTime ? 1 : startDateTime.day}-${DateHelper.getMonthName(month: startDateTime.month)}-${startDateTime.year}';
    String endDate =
        '${startDateTime == endDateTime ? 31 : endDateTime.day}-${DateHelper.getMonthName(month: startDateTime == endDateTime ? startDateTime.month : endDateTime.month)}-${startDateTime.year}';
    print('Date Range : $startDate , $endDate');

    dateDisplay = '$startDate ${AppTranslateKey.to.tr()} $endDate';

    headerType = [
      CategoryType(title: typeTransactionTitle, key: typeTransactionKey),
      CategoryType(title: dateDisplay, key: CategoryEnum.income)
    ];

    List<Query> queryList = [
      Query(
          field: 'date_in_milisecond',
          value: DateHelper.convertDateToMilliSecond(date: startDate),
          operator: QueryOperator.graterThanOrEqual),
      Query(
          field: 'date_in_milisecond',
          value: DateHelper.convertDateToMilliSecond(date: endDate),
          operator: QueryOperator.lessThanOrEqual)
    ];

    if(isInChartView){
      queryList.add(Query(field: 'type', value: typeTransactionKey, operator: QueryOperator.equal));
    }

    var data = await ExpenseRepository.instance.getExpense(
        queryHelper: QueryHelper(
            query: queryList, orderBy: 'date_in_milisecond', direction: direction));

    if (!data.success) {
      PopUpDialog.showErrorDialog(message: data.message);
      return;
    }

    getExpenseModel = data.data!;
    isLoading = false;
    notifyListeners();
  }

  void setNewType({required int index}) {
    if (headerType[index].key == CategoryEnum.expense) {
      headerType[index] = CategoryType(
          title: AppTranslateKey.income.tr(), key: CategoryEnum.income);
    } else {
      headerType[index] = CategoryType(
          title: AppTranslateKey.expenses.tr(), key: CategoryEnum.expense);
    }
    typeTransactionKey = headerType[index].key;
    typeTransactionTitle = headerType[index].title;
    notifyListeners();

    getExpense();
  }

  void setNewDate({required DateTimeRange date}) {
    startDateTime = date.start;
    endDateTime = date.end;
    getExpense();
  }
}
