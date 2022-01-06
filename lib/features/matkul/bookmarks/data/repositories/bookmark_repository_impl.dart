part of '_repositories.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );
  final BookmarkRemoteDataSource _remoteDataSource;
  final BookmarkLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmark(
    QueryBookmark q,
  ) {
    return apiCall(_remoteDataSource.getAllBookmark(q));
  }

  @override
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>>
      getAllBookmarkFromCache() {
    return apiCall(_localDataSource.getAllBookmark());
  }

  @override
  Future<Decide<Failure, void>> postBookmark(
    BookmarkModel bookmark,
    bool isBookmark,
  ) async {
    return apiCall(_remoteDataSource.postBookmark(bookmark, isBookmark));
  }

  @override
  Future<Decide<Failure, void>> postBookmarkToCache(
    BookmarkModel bookmark,
    bool isBookmark,
  ) async {
    return apiCall(_localDataSource.postBookmarkToCache(bookmark, isBookmark));
  }
}
