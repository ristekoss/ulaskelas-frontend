// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_states.dart';

class SearchMatkulState implements FutureState<SearchMatkulState, QuerySearch> {
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

  /// Matkuls getter with dummy data at default.
  List<MatkulModel> get matkuls =>
      _matkuls ??
      <MatkulModel>[
        MatkulModel(
          reviews: 8,
          shortName: 'PL',
          name: 'Pemrograman Lanjut',
          matkulType: 'Wajib IK',
          matkulTypeValue: 'wajibik',
          sks: '2',
        ),
        MatkulModel(
          reviews: 8,
          shortName: 'BD',
          name: 'Basis Data',
          matkulType: 'Wajib SI',
          matkulTypeValue: 'wajibsi',
          sks: '3',
        ),
        MatkulModel(
          reviews: 8,
          shortName: 'KA',
          name: 'Kecerdasan Artifisial dan Sains Data Dasar',
          matkulType: 'Wajib SI',
          matkulTypeValue: 'wajibsi',
          sks: '4',
        ),
        MatkulModel(
          reviews: 8,
          shortName: 'AP',
          name: 'Arsitektur dan Pemrograman Aplikasi Perusahaan',
          matkulType: 'Wajib SI',
          matkulTypeValue: 'wajibsi',
          sks: '4',
        ),
        MatkulModel(
          reviews: 8,
          shortName: 'MD',
          name: 'Matematika Dasar 1',
          matkulType: 'Wajib Fakultas',
          matkulTypeValue: 'wajibfakultas',
          sks: '3',
        ),
        MatkulModel(
          reviews: 5,
          shortName: 'MD',
          name: 'Matematika Diskret 1',
          matkulType: 'Wajib Fakultas',
          matkulTypeValue: 'wajibfakultas',
          sks: '3',
        ),
        MatkulModel(
          reviews: 5,
          shortName: 'MD',
          name: 'Matematika Diskret 1',
          matkulType: 'Wajib Fakultas',
          matkulTypeValue: 'wajibfakultas',
          sks: '3',
        ),
      ];

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
    await Future<void>.delayed(const Duration(seconds: 1));
    _matkuls = matkuls;
  }

  /// Advanced searching combine stateful & stateless search data.
  ///
  /// Prevent duplicates record.
  Future<void> searchMatkul(QuerySearch query) async {
    // TODO(paw): integrate with API
    // final resp = await _repo.getMatkuls(query);
    // resp.fold((failure) {
    //   throw failure;
    // }, (result) {
    //   _hasReachedMax = result.data.isEmpty ||
    //   result.data.length < query.limit;

    // dummy function ignore this
    final _ = matkuls
        .where((element) =>
            (element.name?.toLowerCase().contains(query.q) ?? false) &&
            (!filter.state.isFilteredType ||
                filter.state.selectedType.contains(element.matkulTypeValue)))
        .toList();
    _hasReachedMax = _.length < 5;

    // Prevent duplicate record
    for (final matkul in matkuls) {
      if (!(_matkuls?.contains(matkul) ?? true)) {
        _matkuls?.add(matkul);
      }
    }
    // });
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
