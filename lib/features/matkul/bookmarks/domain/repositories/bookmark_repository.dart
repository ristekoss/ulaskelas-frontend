part of '_repositories.dart';

abstract class BookmarkRepository {
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmark();
  // ignore: lines_longer_than_80_chars
  Future<Decide<Failure, Parsed<List<BookmarkModel>>>> getAllBookmarkFromCache();
}
