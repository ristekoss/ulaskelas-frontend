part of '_datasources.dart';

class BookmarkLocalDataSourceImpl {

  Future<void> postBookmarkToCache(BookmarkModel bookmark) async {
      final rawJson = json.encode(bookmark.toJson());
      await FileService.saveJson('bookmark.json', rawJson);
      Logger().i(rawJson);
  }

}
