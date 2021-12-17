part of '_repositories.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl(
      this._remoteDataSource,
      this._localDataSource,
      );
  
  final BookmarkRemoteDataSourceImpl _remoteDataSource;
  final BookmarkLocalDataSourceImpl _localDataSource;

  @override
  Future<Decide<Failure, void>> postBookmark(
    BookmarkModel bookmark
    ) async {
    return apiCall(_remoteDataSource.postBookmark(bookmark));
  }

  @override
  Future<Decide<Failure, void>> postBookmarkToCache(
    BookmarkModel bookmark
    ) async {
    return apiCall(_localDataSource.postBookmarkToCache(bookmark));
  }
}
