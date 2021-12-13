part of '_datasources.dart';

abstract class BookmarkRemoteDataSource {
  Future<Parsed<List<BookmarkModel>>> getAllBookmark();
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
}
