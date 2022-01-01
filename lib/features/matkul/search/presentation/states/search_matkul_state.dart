// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class SearchMatkulState implements FutureState<SearchMatkulState, QuerySearch> {
  SearchMatkulState() {
    final _remoteDataSource = CourseRemoteDataSourceImpl();
    final _localDataSource = CourseLocalDataSourceImpl();
    _repo = MatkulRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  MatkulRepository? _repo;

  /// Search controller.
  final controller = TextEditingController();

  List<MatkulModel>? _matkuls;

  /// Search history using queue list.
  ///
  /// Defaults to empty.
  ListQueue<String>? _history;
  bool? _hasReachedMax;
  QuerySearch? _query;

  /// Search last query string.
  ///
  /// Defaults to empty string.
  String? _lastQuery;

  int page = 1;

  /// Matkuls getter with dummy data at default.
  List<MatkulModel> get matkuls => _matkuls ?? [];
  List<MatkulModel> get filteredMatkuls {
    return (_matkuls ?? [])
        .where((element) =>
            (element.name
                    ?.toLowerCase()
                    .contains(controller.text.toLowerCase()) ??
                false) &&
            (!filter.state.isFilteredType ||
                filter.state.selectedSks.contains(element.sks.toString()) ||
                filter.state.selectedSemester
                    .contains(element.term.toString())))
        .toList();
  }

  ListQueue<String> get history => _history ?? ListQueue();

  bool get hasReachedMax => _hasReachedMax ?? false;
  set hasReachedMax(bool val) => _hasReachedMax = val;

  QuerySearch get q => _query ?? QuerySearch();

  String get lastQuery => _lastQuery ?? '';
  set lastQuery(String val) => _lastQuery = val;

  @override
  String? cacheKey = CacheKey.newsState;

  @override
  bool getCondition() {
    return true;
  }

  @override
  Future<void> retrieveData(QuerySearch query) async {
    await searchMatkul(query);
  }

  /// Advanced searching combine stateful & stateless search data.
  ///
  /// Prevent duplicates record.
  Future<void> searchMatkul(QuerySearch query) async {
    page = 1;
    query.page = 1;
    _hasReachedMax = false;
    final resp = await _repo?.getAllMatkul(query);
    resp?.fold((failure) {
      throw failure;
    }, (result) {
      final lessThanLimit = result.data.length < query.limit;
      _hasReachedMax = result.data.isEmpty || lessThanLimit;

      // Prevent duplicate record
      filterCourse(result.data);
    });
  }

  Future<void> retrieveMoreData(QuerySearch query) async {
    ++page;
    query.page = page;
    final resp = await _repo?.getAllMatkul(query);
    resp?.fold((failure) {
      throw failure;
    }, (result) {
      final lessThanLimit = result.data.length < query.limit;
      _hasReachedMax = result.data.isEmpty || lessThanLimit;

      // Prevent duplicate record
      filterCourse(result.data);
    });
  }

  void filterCourse(List<MatkulModel> matkuls) {
    _matkuls ??= matkuls;
    for (final matkul in matkuls) {
      if (!(_matkuls?.contains(matkul) ?? true)) {
        _matkuls?.add(matkul);
      }
    }
  }

  /// Every submitted query will added to history
  void addToHistory(String query) {
    _history ??= ListQueue<String>();
    if (!history.contains(query)) {
      _history?.addFirst(query);
    }
    if (history.length == 11) {
      _history?.removeLast();
    }
    // TODO(pawpaw: save to local storage)
  }

  /// Clear search history from local state and local storage.
  void clearHistory() {
    _history?.clear();
    // TODO(pawpaw: clear from local storage)
  }
}
