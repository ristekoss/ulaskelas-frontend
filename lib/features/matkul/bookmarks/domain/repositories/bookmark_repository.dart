part of '_repositories.dart';

abstract class BookmarkRepository {
  Future<Decide<Failure, void>> postBookmark(BookmarkModel bookmark);
  Future<Decide<Failure, void>> postBookmarkToCache(BookmarkModel bookmark);
}
