class QueryHelper {
  List<Query> query = [];
  String? lastDocumentID;
  String? orderBy;
  String? direction;
  int? limit;

  QueryHelper(
      {this.query = const [],
        this.lastDocumentID,
        this.orderBy,
        this.direction,
        this.limit});

  QueryHelper.fromJson(Map<String, dynamic> json) {
    if (json['query'] != null) {
      query = <Query>[];
      json['query'].forEach((v) {
        query.add(Query.fromJson(v));
      });
    }
    lastDocumentID = json['lastDocumentID'];
    orderBy = json['orderby'];
    direction = json['direction'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query.map((v) => v.toJson()).toList();
      data['lastDocumentID'] = lastDocumentID;
    data['orderBy'] = orderBy;
    data['direction'] = direction;
    data['limit'] = limit;
    return data;
  }
}

class Query {
  String? field;
  dynamic value;
  QueryOperator? operator;

  Query({required this.field, required this.value, required this.operator});

  Query.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    value = json['value'];
    operator = json['operator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field'] = field;
    data['value'] = value;
    data['operator'] = operator!.operator.toString();
    return data;
  }
}

enum QueryOperator{
  equal('=='),
  lessThan('<'),
  graterThan('>'),
  lessThanOrEqual('<='),
  graterThanOrEqual('>=');
  final String operator;
  const QueryOperator(this.operator);
}
