class QueryCalculator {
  int? id;

  QueryCalculator({
    this.id,
  });

  @override
  String toString() {
    final data = <String, String>{};
    data['id'] = id.toString();
    return Uri(queryParameters: data).query;
  }
}
