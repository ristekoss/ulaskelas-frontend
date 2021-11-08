// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_entities.dart';

class QuerySearch {
  // TODO(pawpaw): API query
  @override
  String toString() {
    final data = <String, String>{};
    return Uri(queryParameters: data).query;
  }
}
