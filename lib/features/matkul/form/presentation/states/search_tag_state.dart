part of '_states.dart';

class SearchTagState implements FutureState<SearchTagState, QuerySearchTag> {
  SearchTagState() {
    final _remoteDataSource = TagRemoteDataSourceImpl();
    final _localDataSource = TagLocalDataSourceImpl();
    _repo = TagRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  late TagRepository _repo;

  /// Search controller.
  final controller = TextEditingController();
  int page = 1;

  List<String>? _selectedTags;
  List<String>? _tags;

  List<String> get selectedTags => _selectedTags ?? [];

  bool? _hasReachedMax;
  QuerySearch? _query;

  /// Search last query string.
  ///
  /// Defaults to empty string.
  String? _lastQuery;

  /// Tags getter with dummy data at default.
  List<String> get tags => _tags!;

  bool get hasReachedMax => _hasReachedMax ?? false;
  set hasReachedMax(bool val) => _hasReachedMax = val;

  QuerySearch get q => _query ?? QuerySearch();

  String get lastQuery => _lastQuery ?? '';
  set lastQuery(String val) => _lastQuery = val;

  @override
  String? cacheKey = CacheKey.searchTagState;

  @override
  bool getCondition() {
    return true;
  }

  @override
  Future<void> retrieveData(QuerySearchTag query) async {
    page = 1;
    query.page = 1;
    final resp = await _repo.getAllTag(query);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      _hasReachedMax = result.data.isEmpty || lessThanLimit;
      _tags = result.data;
    });
  }

  Future<void> retrieveMoreData(QuerySearchTag query) async {
    ++page;
    query.page = page;
    final resp = await _repo.getAllTag(query);
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      _hasReachedMax = result.data.isEmpty || lessThanLimit;

      // Prevent duplicate record
      filterTag(result.data);
    });
  }

  void filterTag(List<String> tags) {
    _tags ??= tags;
    for (final tag in tags) {
      if (!(_tags?.contains(tag) ?? true)) {
        _tags?.add(tag);
      }
    }
  }

  /// Advanced searching combine stateful & stateless search data.
  ///
  /// Prevent duplicates record.
  Future<void> searchTag(QuerySearch query) async {
    // TODO(paw): integrate with API
    // final resp = await _repo.getMatkuls(query);
    // resp.fold((failure) {
    //   throw failure;
    // }, (result) {
    //   _hasReachedMax = result.data.isEmpty ||
    //   result.data.length < query.limit;

    // dummy function ignore this
    final _ = tags
        .where(
          (element) => element.toLowerCase().contains(query.q),
        )
        .toList();
    // _hasReachedMax = _.length < 5;
    _hasReachedMax = true;

    // Prevent duplicate record
    for (final tag in tags) {
      if (!(_tags?.contains(tag) ?? true)) {
        _tags?.add(tag);
      }
    }
    // });
  }

  /// Switching Tag
  void switchTag(String model) {
    _selectedTags ??= <String>[];
    if (!(_selectedTags?.contains(model) ?? true)) {
      _selectedTags?.add(model);
    } else {
      _selectedTags?.remove(model);
    }
  }

  void addNewTag(String tag) {
    if (!(_tags?.contains(tag) ?? true)) {
      _tags?.add(tag);
    }
  }

  /// Local Search
  List<String> localSearch() {
    final query = controller.text.toLowerCase();
    final matkulTags = tags
        .where(
          (element) => element.toLowerCase().contains(query),
        )
        .toList();
    return matkulTags;
  }

  /// Terapkan tag
  void select() {
    nav.pop<List<String>>(selectedTags);
  }

  void cleanSearch() {
    _selectedTags?.clear();
  }
}
