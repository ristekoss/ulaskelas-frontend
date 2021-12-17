part of '_datasources.dart';

abstract class BookmarkLocalDataSource {
  Future<Parsed<List<BookmarkModel>>> getAllBookmark();
  Future<void> postBookmarkToCache(BookmarkModel bookmark);
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

  Future<void> postBookmarkToCache(BookmarkModel bookmark) async {
      final rawJson = json.encode(bookmark.toJson());
      await FileService.saveJson('bookmark.json', rawJson);
      Logger().i(rawJson);
  }
  
}
