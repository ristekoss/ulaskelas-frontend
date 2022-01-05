part of '_datasources.dart';

abstract class BookmarkLocalDataSource {
  Future<Parsed<List<BookmarkModel>>> getAllBookmark();
  Future<void> postBookmarkToCache(BookmarkModel bookmark, bool isBookmark);
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  @override
  Future<Parsed<List<BookmarkModel>>> getAllBookmark() async {
    final list = <BookmarkModel>[];

    /// load json from cache
    final file = await FileService.getJson('bookmark.json');
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    for (final data in json['data']) {
      list.add(BookmarkModel.fromJson(data));
    }
    return Parsed.fromJson(json, 200, list);
  }

  @override
  Future<void> postBookmarkToCache(
    BookmarkModel bookmark,
    bool isBookmark,
  ) async {
    final resp = await getAllBookmark();
    if (resp.statusCode == 200) {
      if (!isBookmark) {
        final bookmarks = resp.data;

        if (!bookmarks.contains(bookmark)) {
          bookmarks.add(bookmark);
          final data = jsonEncode({
            'data': bookmarks.map((e) => e.toJson()).toList(),
          });

          final rawJson = json.encode(data);
          await FileService.saveJson('bookmark.json', rawJson);

          // log if bookmarks change
          Logger().i(rawJson);
        }
      } else {
        final bookmarks = resp.data;
        if (bookmarks.contains(bookmark)) {
          bookmarks.remove(bookmark);
          final data = jsonEncode({
            'data': bookmarks.map((e) => e.toJson()).toList(),
          });

          final rawJson = json.encode(data);
          await FileService.saveJson('bookmark.json', rawJson);

          // log if bookmarks change
          Logger().i(rawJson);
        }
      }
    }
  }
}
