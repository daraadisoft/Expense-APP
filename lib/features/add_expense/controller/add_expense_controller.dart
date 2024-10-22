import 'package:easy_localization/easy_localization.dart';
import 'package:expense_app/features/add_expense/model/category_model.dart';
import 'package:expense_app/repo/category_repository.dart';
import 'package:expense_app/utils/app_translate_key.dart';
import 'package:expense_app/utils/base_controller.dart';
import 'package:expense_app/utils/data/category_enum.dart';
import 'package:expense_app/utils/data/category_type.dart';

class AddExpenseController extends BaseController {
  @override
  Future<void> init() async {
    super.init();
    getListCategory();
  }

  int indexType = 0;

  bool isLoading = false;

  List<CategoryType> categoryType = [
    CategoryType(
        title: AppTranslateKey.expense.tr(), key: CategoryEnum.expense),
    CategoryType(title: AppTranslateKey.income.tr(), key: CategoryEnum.income)
  ];

  List<CategoryModel> listCategory = [];

  void changeIndexType({required int data}) {
    indexType = data;
    notifyListeners();
  }

  void getListCategory() async {
    isLoading = true;
    notifyListeners();

    var data = await CategoryRepository.instance.getCategory();

    listCategory.addAll(data.data ?? []);

    isLoading = false;
    notifyListeners();
  }
}
