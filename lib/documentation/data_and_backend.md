# 👨‍💻 Ulas Kelas Back End & Data Communication

Ulas Kelas Communication with application programming interface

## ⚡️ Getting Started

### Define API endpoints

Add endpoint to this class
example at lib/core/environment/endpoints.dart
```dart
class Endpoints {
  /// Base Endpoints.
  static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  static const localHost = 'http://127.0.0.1:8000';
  static const baseUrlDev = 'https://apidev-ulaskelas.ristek.cs.ui.ac.id';
  static const baseUrlProd = 'https://apidev-ulaskelas.ristek.cs.ui.ac.id';
  static final sso = '$baseUrl/login';
  static final ssoMobile = '$baseUrl/login/?redirect_url=${Endpoints.token}';
  static final token = '$baseUrl/token';
  static final users = '$baseUrl/users';
  static final userId = '$baseUrl/users/{{Id}}';
  static final review = '$baseUrl/api/reviews';
  static final courses = '$baseUrl/api/courses';
  static final bookmarks = '$baseUrl/api/bookmarks';
}
```

### Create Data Source & Repository

Create Remote Data Source to communicate with remote server
example at lib/features/matkul/search/data/datasources/matkul_remote_data_source.dart
```dart
abstract class MatkulRemoteDataSource {
  Future<Parsed<List<MatkulModel>>> getAllMatkul();
}

class MatkulRemoteDataSourceImpl implements MatkulRemoteDataSource {
  @override
  Future<Parsed<List<MatkulModel>>> getAllMatkul() async {
    final list = <MatkulModel>[];
    final url = Endpoints.courses;
    final resp = await getIt(url);
    for (final data in resp.dataBodyAsMap['courses']) {
      list.add(MatkulModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      /// Save json to cache
      await FileService.saveJson('matkul.json', jsonEncode(resp.data));
    }
    return resp.parse(list);
  }
}
```

Create Local data source to communicate with local data.
Helpful when NetworkFailure or SocketException occur.
```dart
abstract class MatkulLocalDataSource {
  Future<Parsed<List<MatkulModel>>> getAllMatkul();
}

class MatkulLocalDataSourceImpl implements MatkulLocalDataSource {
  @override
  Future<Parsed<List<MatkulModel>>> getAllMatkul() async {
    final list = <MatkulModel>[];
    /// Load json from cache
    final file = await FileService.getJson('matkul.json');
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    for (final data in json['data']['courses']) {
      list.add(MatkulModel.fromJson(data));
    }
    return Parsed.fromJson(json, 200, list);
  }
}
```


example at lib/features/matkul/search/domain/repositores/matkul_repository.dart
```dart
abstract class MatkulRepository {
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkul();
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkulFromCache();
}
```

example at lib/features/matkul/search/data/repositores/matkul_repository_impl.dart.
```dart
class MatkulRepositoryImpl implements MatkulRepository {
  MatkulRepositoryImpl(
      this._remoteDataSource,
      this._localDataSource,
      );

  final MatkulRemoteDataSource _remoteDataSource;
  final MatkulLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkul() {
    return apiCall(_remoteDataSource.getAllMatkul());
  }

  @override
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkulFromCache() {
    return apiCall(_localDataSource.getAllMatkul());
  }
}
```

In your state class for example SearchMatkulState.
example at lib/features/matkul/search/presentation/states/search_matkul_state.dart.
```dart
class SearchMatkulState implements FutureState<SearchMatkulState, QuerySearch> {
  SearchMatkulState() {
    final _remoteDataSource = MatkulRemoteDataSourceImpl();
    final _localDataSource = MatkulLocalDataSourceImpl();
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
    final resp = await _repo?.getAllMatkul();
    resp?.fold((failure) {
      throw failure;
    }, (result) {
      _matkuls = result.data;
      _hasReachedMax = true;

      // Prevent duplicate record
      for (final matkul in matkuls) {
        if (!(_matkuls?.contains(matkul) ?? true)) {
          _matkuls?.add(matkul);
        }
      }
    });
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
```
