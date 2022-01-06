class QueryBookmark {
  int page;

  QueryBookmark({this.page = 1});

  @override
  String toString() {
    final data = <String, String>{};
    // data['page'] = page.toString();
    return Uri(queryParameters: data).query;
  }
}
