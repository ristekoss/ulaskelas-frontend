part of '_datasources.dart';

abstract class BookmarkRemoteDataSource {
  Future<Parsed<List<BookmarkModel>>> getAllBookmark(QueryBookmark q);
  Future<void> postBookmark(BookmarkModel bookmark, bool isBookmark);
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  @override
  Future<Parsed<List<BookmarkModel>>> getAllBookmark(QueryBookmark q) async {
    final list = <BookmarkModel>[];
    final url = '${Endpoints.bookmarks}?$q';
    final resp = await getIt(url);
    for (final data in resp.dataBodyIterable) {
      list.add(BookmarkModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      // save json to cache
      await FileService.saveJson('bookmark.json', jsonEncode(resp.data));
    }
    return resp.parse(list);
  }

  @override
  Future<void> postBookmark(BookmarkModel bookmark, bool isBookmark) async {
    final url = Endpoints.bookmarks;
    final resp = await postIt(
      url,
      model: <String, dynamic>{
        'course_code': bookmark.courseCode,
        'is_bookmark': isBookmark,
      },
    );
    if (resp.statusCode == 200 || resp.statusCode == 204) {
      Logger().i('Bookmark deleted');
    } else {
      Logger().e('Error deleting bookmark');
    }
  }
}
