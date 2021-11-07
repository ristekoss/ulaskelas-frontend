// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class SearchState implements FutureState<SearchState, QuerySearch> {
  @override
  String? cacheKey;

  @override
  bool getCondition() {
    // TODO(pawpaw): implement getCondition
    return true;
  }

  @override
  Future<void> retrieveData(QuerySearch query) async {
    // TODO(pawpaw): implement retrieveData
    // throw UnimplementedError();
  }
}
