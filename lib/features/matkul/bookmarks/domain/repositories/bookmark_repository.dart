part of '_repositories.dart';

abstract class BookmarkRepository {
  Future<Decide<Failure, void>> postBookmark(BookmarkModel bookmark);
  Future<Decide<Failure, void>> postBookmarkToCache(BookmarkModel bookmark);
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmark();
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmarkFromCache();
}
