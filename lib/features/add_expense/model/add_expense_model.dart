class AddExpenseModel {
  final String date;
  final String categoryID;
  final String note;
  final double amount;

  AddExpenseModel({
    required this.date,
    required this.amount,
    required this.categoryID,
    required this.note,
  });

  Map toJson() => {
        "categoryID": categoryID,
        "amount": amount,
        "description": note,
        "date": date
      };
}
