import 'package:expense_app/features/add_expense/model/get_expense_model.dart';
import 'package:expense_app/repo/expense_repository.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/data/query_helper.dart';
import 'package:expense_app/utils/date_helper.dart';
import 'package:expense_app/utils/widget/pop_up_dialog.dart';

class RecordController extends BaseController {
  bool isLoading = false;
  GetExpenseModel getExpenseModel = GetExpenseModel();
  DateTime dateTime = DateTime.now();

  @override
  Future init() async {
    super.init();
    getExpense();
  }

  void getExpense() async {
    isLoading = true;
    notifyListeners();
    String startDate = '01-${DateHelper.getMonthName(month: dateTime.month)}-${dateTime.year}';
    String endDate  =  '31-${DateHelper.getMonthName(month: dateTime.month)}-${dateTime.year}';
    var data = await ExpenseRepository.instance.getExpense(
        queryHelper: QueryHelper(query: [
      Query(
          field: 'date_in_milisecond',
          value: DateHelper.convertDateToMilliSecond(
              date: startDate),
          operator: QueryOperator.graterThanOrEqual),
      Query(
          field: 'date_in_milisecond',
          value: DateHelper.convertDateToMilliSecond(
              date: endDate),
          operator: QueryOperator.lessThanOrEqual)
    ], orderBy: 'date_in_milisecond', direction: 'desc'));

    if (!data.success) {
      PopUpDialog.showErrorDialog(message: data.message);
      return;
    }

    isLoading = false;
    notifyListeners();
  }
}
