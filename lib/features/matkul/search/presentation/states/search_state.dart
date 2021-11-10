// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class SearchMatkulState implements FutureState<SearchMatkulState, QuerySearch> {
  List<MatkulModel>? _matkuls;
  bool? _hasReachedMax;
  QuerySearch? _query;

  List<MatkulModel>? get matkuls => _matkuls;
  bool get hasReachedMax => _hasReachedMax ?? false;
  QuerySearch get q => _query ?? QuerySearch();

  @override
  String? cacheKey = CacheKey.newsState;

  @override
  bool getCondition() {
    return true;
  }

  @override
  Future<void> retrieveData(QuerySearch query) async {
    // TODO(pawpaw): implement retrieveData
    // throw UnimplementedError();
  }

  Future<void> searchMatkul(QuerySearch query) async {}
}
