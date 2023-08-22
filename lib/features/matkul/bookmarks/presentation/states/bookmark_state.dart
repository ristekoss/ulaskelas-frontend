part of '_states.dart';

class BookmarkState {
  BookmarkState() {
    final remoteDataSource = BookmarkRemoteDataSourceImpl();
    final localDataSource = BookmarkLocalDataSourceImpl();
    _repo = BookmarkRepositoryImpl(
      remoteDataSource,
      localDataSource,
    );
  }

  late BookmarkRepository _repo;
  List<BookmarkModel>? _bookmarks;
  List<BookmarkModel> get bookmarks => _bookmarks ?? [];

  bool hasReachedMax = false;
  int page = 1;

  String? cacheKey = 'bookmark-state';

  bool getCondition() {
    print('data ${_bookmarks?.isNotEmpty}');
    return _bookmarks?.isNotEmpty ?? false;
  }

  Future<void> retrieveData(QueryBookmark q) async {
    final resp = await _repo.getAllBookmark(q);
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _bookmarks = result.data;
      print(_bookmarks);
    });
    bookmarkRM.notify();
  }

  bool isMarked(CourseModel model) {
    for (final e in bookmarks) {
      if (e.courseCode == model.code) return true;
    }
    return false;
  }

  /// tap to toggle Bookmark
  Future<void> toggleBookmark(BookmarkModel bookmark) async {
    final resp = await _repo.getAllBookmark(QueryBookmark());
    resp.fold((failure) {
      throw failure;
    }, (result) {
      _bookmarks = result.data;

      // Prevent duplicate record
      for (final bookmark in _bookmarks!) {
        if (!(_bookmarks?.contains(bookmark) ?? true)) {
          _bookmarks?.add(bookmark);
        }
      }

      if (_bookmarks?.contains(bookmark) ?? true) {
        // remove if in _bookmarks
        _repo.postBookmark(bookmark, false);
        _bookmarks?.remove(bookmark);
      } else {
        // create if not in _bookmarks
        _repo.postBookmark(bookmark, true);
        SuccessMessenger('Mata kuliah berhasil disimpan').show(ctx!);
        _bookmarks?.add(bookmark);
      }
    });
  }
}
