part of '_states.dart';

class BookmarkState {
  BookmarkState() {
    final _remoteDataSource = BookmarkRemoteDataSourceImpl();
    final _localDataSource = BookmarkLocalDataSourceImpl();
    _repo = BookmarkRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  BookmarkRepository? _repo;
  List<BookmarkModel>? _bookmarks;


  List<BookmarkModel> get bookmarks => _bookmarks ?? [];

  /// tap to toggle Bookmark
  Future<void> toggleBookmark(BookmarkModel bookmark) async {
    final resp = await _repo?.getAllBookmark();
    resp?.fold((failure) {
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
        _repo?.postBookmark(bookmark, true);
        _bookmarks?.remove(bookmark);
      } else {
        // create if not in _bookmarks
        _repo?.postBookmark(bookmark, false);
        _bookmarks?.add(bookmark);
      }
    });
  }
}
