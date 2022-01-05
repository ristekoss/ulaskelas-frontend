// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class SearchCourseState
    implements FutureState<SearchCourseState, QuerySearchCourse> {
  SearchCourseState() {
    final _remoteDataSource = CourseRemoteDataSourceImpl();
    final _localDataSource = CourseLocalDataSourceImpl();
    _repo = CourseRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  CourseRepository? _repo;

  /// Search controller.
  final controller = TextEditingController();

  List<CourseModel>? _matkuls;

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

  /// Courses getter with dummy data at default.
  List<CourseModel> get courses => _matkuls ?? [];
  List<CourseModel> get filteredCourses {
    return (_matkuls ?? [])
        .where(
          (element) =>
              (element.name
                      ?.toLowerCase()
                      .contains(controller.text.toLowerCase()) ??
                  false) &&
              (!filterRM.state.isFilteredType ||
                  filterRM.state.selectedSks.contains(element.sks.toString()) ||
                  filterRM.state.selectedSemester
                      .contains(element.term.toString())),
        )
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
  Future<void> retrieveData(QuerySearchCourse query) async {
    await searchMatkul(query);
  }

  /// Advanced searching combine stateful & stateless search data.
  ///
  /// Prevent duplicates record.
  Future<void> searchMatkul(QuerySearchCourse query) async {
    page = 1;
    query.page = 1;
    _hasReachedMax = false;
    final now = DateTime.now();
    final cachedDay = DateTime.parse(
      Pref.getString(Filename.courses) ?? now.toIso8601String(),
    );
    final isDiffDay = cachedDay.difference(now) > const Duration(days: 1) ||
        !Pref.containsKey(Filename.courses);
    final resp = isDiffDay
        ? await _repo?.getAllCourse(query)
        : await _repo?.getAllCachedCourse();
    resp?.fold((failure) {
      if (failure is NetworkFailure) {
      } else {
        throw failure;
      }
    }, (result) {
      final lessThanLimit = result.data.length < query.limit;
      _hasReachedMax = result.data.isEmpty || lessThanLimit;
      // TODO(pawpaw): set this to false.
      _hasReachedMax = true;
      // Prevent duplicate record
      filterCourse(result.data);
    });
  }

  Future<void> retrieveFromCache() async {
    final resp = await _repo?.getAllCachedCourse();
    resp?.fold((failure) {
      throw failure;
    }, (result) {
      filterCourse(result.data);
    });
  }

  Future<void> retrieveMoreData(QuerySearchCourse query) async {
    ++page;
    query.page = page;
    final resp = await _repo?.getAllCourse(query);
    resp?.fold((failure) {
      throw failure;
    }, (result) {
      final lessThanLimit = result.data.length < query.limit;
      _hasReachedMax = result.data.isEmpty || lessThanLimit;

      // Prevent duplicate record
      filterCourse(result.data);
    });
  }

  void filterCourse(List<CourseModel> matkuls) {
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
    // TODO(pawpaw): save to local storage
  }

  /// Clear search history from local state and local storage.
  void clearHistory() {
    _history?.clear();
    // TODO(pawpaw): clear from local storage
  }
}
