import 'package:expense_app/features/add_expense/model/add_expense_model.dart';
import 'package:expense_app/features/add_expense/model/get_expense_model.dart';
import 'package:expense_app/utils/app_url.dart';
import 'package:expense_app/utils/data/data_state.dart';
import 'package:expense_app/utils/data/query_helper.dart';
import 'package:expense_app/utils/http_service.dart';

class ExpenseRepository {
  ExpenseRepository._privateConstructor();

  static final ExpenseRepository instance =
      ExpenseRepository._privateConstructor();

  factory ExpenseRepository() {
    return instance;
  }

  Future<DataState<Map>> createExpense(
      {required AddExpenseModel addExpenseModel}) async {
    try {
      var response = await HttpService.httpService
          .post(url: AppUrl.createExpense, body: addExpenseModel.toJson());
      return DataState(
          data: response.data['data'],
          success: response.data['success'],
          message: response.data['message']);
    } catch (e) {
      return DataState(data: null, success: false, message: e.toString());
    }
  }

  Future<DataState<GetExpenseModel>> getExpense(
      {QueryHelper? queryHelper}) async {
    try {
      var response = await HttpService.httpService.post(
          url: AppUrl.getExpense,
          body: queryHelper == null ? {} : queryHelper.toJson());

      GetExpenseModel getExpenseModel = GetExpenseModel();

      if (response.statusCode == HttpCode.success) {
        getExpenseModel = GetExpenseModel.fromJson(response.data['data'] ?? {});
      }

      return DataState(
          data: getExpenseModel,
          success: response.data['success'],
          message: response.data['message'],
          lastDocumentID: response.data['lastDocumentID'],
          total: response.data['count'],
          totalPage: response.data['totalPage'],
          isHasNextPage: response.data['hasNextPage']);
    } catch (e) {
      return DataState(success: false, message: e.toString());
    }
  }
}
