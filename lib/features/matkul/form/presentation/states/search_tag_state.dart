part of '_states.dart';

class SearchTagState implements FutureState<SearchTagState, QuerySearch> {
  /// Search controller.
  final controller = TextEditingController();

  List<TagModel>? _selectedTags;
  List<TagModel>? _tags;

  List<TagModel> get selectedTags => _selectedTags ?? [];

  bool? _hasReachedMax;
  QuerySearch? _query;

  /// Search last query string.
  ///
  /// Defaults to empty string.
  String? _lastQuery;

  /// Matkuls getter with dummy data at default.
  List<TagModel> get tags =>
      _tags ??
      <TagModel>[
        TagModel(
          id: 1,
          name: 'Pemrograman Lanjut',
        ),
        TagModel(
          id: 2,
          name: 'Basis Data',
        ),
        TagModel(
          id: 3,
          name: 'Kecerdasan Artifisial dan Sains Data Dasar',
        ),
        TagModel(
          id: 4,
          name: 'Arsitektur dan Pemrograman Aplikasi Perusahaan',
        ),
        TagModel(
          id: 5,
          name: 'Matematika Dasar 1',
        ),
        TagModel(
          id: 6,
          name: 'Matematika Diskret 1',
        ),
        TagModel(
          id: 7,
          name: 'Matematika Diskret 1',
        ),
        TagModel(
          id: 8,
          name: 'Matematika Diskret 2',
        ),
      ];

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
  Future<void> retrieveData(QuerySearch query) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _tags = tags;
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
          (element) => element.name.toLowerCase().contains(query.q),
        )
        .toList();
    _hasReachedMax = _.length < 5;

    // Prevent duplicate record
    for (final tag in tags) {
      if (!(_tags?.contains(tag) ?? true)) {
        _tags?.add(tag);
      }
    }
    // });
  }

  /// Switching Tag
  void switchTag(TagModel model) {
    _selectedTags ??= <TagModel>[];
    if (!(_selectedTags?.contains(model) ?? true)) {
      _selectedTags?.add(model);
    } else {
      _selectedTags?.remove(model);
    }
  }

  /// Local Search
  List<TagModel> localSearch() {
    final query = controller.text.toLowerCase();
    final matkulTags = tags
        .where(
          (element) => element.name.toLowerCase().contains(query),
        )
        .toList();
    return matkulTags;
  }

  /// Terapkan tag
  void select() {
    nav.pop<List<TagModel>>(selectedTags);
  }

  void cleanSearch() {
    _selectedTags?.clear();
  }
}
