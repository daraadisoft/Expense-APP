class CategoryModel {
  String? name;
  String? url;
  String? type;
  String? color;
  String? id;
  double? amount;
  CategoryModel({this.name, this.url, this.type, this.color, this.id});
  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    type = json['type'];
    color = json['color'];
    id = json['id'];
    amount = double.tryParse(json['amount'].toString()) ?? 0;
  }
}
