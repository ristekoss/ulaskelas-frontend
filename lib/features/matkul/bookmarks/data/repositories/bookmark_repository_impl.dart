part of '_repositories.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl(this._remoteDataSource, this._localDataSource);
  final BookmarkRemoteDataSource _remoteDataSource;
  final BookmarkLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmark() {
    return apiCall(_remoteDataSource.getAllBookmark());
  }

  @override
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmarkFromCache() {
    return apiCall(_localDataSource.getAllBookmark());
  }

  @override
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, void>> postBookmark(BookmarkModel bookmark, isBookmark) async {
    return apiCall(_remoteDataSource.postBookmark(bookmark, isBookmark));
  }

  @override
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, void>> postBookmarkToCache(BookmarkModel bookmark, isBookmark) async {
    return apiCall(_localDataSource.postBookmarkToCache(bookmark, isBookmark));
  }
}
