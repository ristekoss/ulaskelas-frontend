part of '_datasources.dart';

abstract class BookmarkRemoteDataSource {
  Future<Parsed<List<BookmarkModel>>> getAllBookmark();
  Future<void> postBookmark(BookmarkModel bookmark, bool isBookmark);
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  @override
  Future<Parsed<List<BookmarkModel>>> getAllBookmark() async {
    final list = <BookmarkModel>[];
    final url = Endpoints.bookmarks;
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

  Future<void> postBookmark(BookmarkModel bookmark, bool isBookmark) async {
    final url = Endpoints.bookmarks;
    if (isBookmark) {
      final resp = await postIt(url, model: bookmark.toJson());
      if (resp.statusCode == 200) {
        Logger().i('Bookmark posted');
      } else {
        Logger().e('Error posting bookmark');
      }
    } else {
      final resp = await deleteIt(url, model: bookmark.toJson());
      if (resp.statusCode == 200 || resp.statusCode == 204) {
        Logger().i('Bookmark deleted');
      } else {
        Logger().e('Error deleting bookmark');
      }
    }
  }
}
