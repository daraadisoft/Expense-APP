class DataState<T> {
  T? data;
  int total;
  String message;
  int totalPage;
  String? lastDocumentID;
  bool isHasNextPage;
  bool success;

  DataState(
      {this.data,
      this.message = '',
      this.total = 0,
      this.totalPage = 0,
      this.isHasNextPage = false,
      this.success = false,
      this.lastDocumentID});
}
