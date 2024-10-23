import 'package:expense_app/features/add_expense/model/category_model.dart';
import 'package:expense_app/utils/app_url.dart';
import 'package:expense_app/utils/data/data_state.dart';
import 'package:expense_app/utils/data/query_helper.dart';
import 'package:expense_app/utils/http_service.dart';

class CategoryRepository {
  CategoryRepository._privateConstructor();

  static final CategoryRepository instance =
      CategoryRepository._privateConstructor();

  factory CategoryRepository() {
    return instance;
  }

  Future<DataState<List<CategoryModel>>> getCategory(
      {QueryHelper? queryHelper}) async {
    try {
      var response = await HttpService.httpService.post(
          url: AppUrl.getCategory,
          body: queryHelper != null ? queryHelper.toJson() : {});
      List<CategoryModel> data = [];
      if (response.statusCode == HttpCode.success) {
        for (var item in response.data['data']) {
          data.add(CategoryModel.fromJson(item));
        }
      }
      return DataState(
          data: data,
          message: response.data['message'],
          lastDocumentID: response.data['lastDocumentID'],
          total: response.data['count'],
          isHasNextPage: response.data['hasNextPage'],
          totalPage: response.data['totalPage']);
    } catch (e) {
      return DataState(data: [], message: e.toString());
    }
  }
}
