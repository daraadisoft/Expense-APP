import 'category_model.dart';

class GetExpenseModel {
  double? totalExpense;
  double? totalIncome;
  double? balance;

  List<CategoryModel> pieChart = [];

  List<DateExpense> dateExpense = [];

  GetExpenseModel(
      {this.balance = 0,
      this.totalExpense = 0,
      this.totalIncome = 0,
      this.pieChart = const [],
      this.dateExpense = const []
      });

  GetExpenseModel.fromJson(Map json) {
    totalExpense = double.tryParse(json['totalExpense'].toString()) ?? 0;
    totalIncome = double.tryParse(json['totalIncome'].toString()) ?? 0;
    balance = double.tryParse(json['balance'].toString()) ?? 0;

    for (var item in json['groupedTransactions']) {
      dateExpense.add(DateExpense.fromJson(item));
    }

    for (var item in json['pieChart']) {
      pieChart.add(CategoryModel.fromJson(item));
    }
  }
}

class DateExpense {
  String? date;
  double? expense;
  double? income;
  List<Transaction> transactions = [];

  DateExpense(
      {this.date = '',
      this.income = 0,
      this.expense = 0,
      this.transactions = const []});

  DateExpense.fromJson(Map json) {
    date = json['date'].toString();
    expense = double.tryParse(json['expense'].toString()) ?? 0;
    income = double.tryParse(json['income'].toString()) ?? 0;
    for (var item in json['transactions']) {
      transactions.add(Transaction.fromJson(item));
    }
  }
}

class Transaction {
  double? amount;
  String? id;
  String? description;
  CategoryModel categoryModel = CategoryModel();

  Transaction({this.id = '', this.amount = 0, this.description = ''});

  Transaction.fromJson(Map json) {
    categoryModel = CategoryModel.fromJson(json['category']);
    description = json['description'].toString();
    amount = double.tryParse(json['amount'].toString()) ?? 0;
    id = json['id'].toString();
  }
}
