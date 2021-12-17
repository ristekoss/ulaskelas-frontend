part of '_datasources.dart';

class BookmarkRemoteDataSourceImpl {

  Future<void> postBookmark(BookmarkModel bookmark) async {
    final url = Endpoints.bookmarks;
    final resp = await postIt(url, model: bookmark.toJson());
    if (resp.statusCode == 200) {
      Logger().i('Bookmark posted');
    } else {
      Logger().e('Error posting bookmark');
    }
  }
  
}