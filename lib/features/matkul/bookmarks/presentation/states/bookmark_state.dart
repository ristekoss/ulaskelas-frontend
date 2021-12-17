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
  void toggleBookmark(BookmarkModel bookmark) {
    if (bookmark.isBookmark == true) {
      bookmark.isBookmark = false;
      _repo?.postBookmark(bookmark);
    } else {
      bookmark.isBookmark = true;
      _repo?.postBookmark(bookmark);
    }
  }
}
