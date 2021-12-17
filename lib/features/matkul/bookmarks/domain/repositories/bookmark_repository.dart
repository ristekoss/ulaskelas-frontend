part of '_repositories.dart';

abstract class BookmarkRepository {
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, void>> postBookmark(BookmarkModel bookmark, bool isBookmark);
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, void>> postBookmarkToCache(BookmarkModel bookmark, bool isBookmark);
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmark();
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmarkFromCache();
}
