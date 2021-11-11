// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_entities.dart';

class QuerySearch {
  QuerySearch({
    this.page,
    this.limit = Constants.limitPagination,
    this.q = '',
  });

  int? page;
  int limit;
  String q;

  @override
  String toString() {
    final data = <String, String>{};
    data['page'] = page.toString();
    data['limit'] = limit.toString();
    data['q'] = q;
    return Uri(queryParameters: data).query;
  }
}
