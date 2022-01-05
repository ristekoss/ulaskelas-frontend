// Created by Muhamad Fauzi Ridwan on 05/12/21.
part of '_datasources.dart';

abstract class CourseLocalDataSource {
  Future<Parsed<List<CourseModel>>> getAllCourse();
  Future<Parsed<List<BookmarkModel>>> getAllBookmarkedCourse(String code);
}

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  @override
  Future<Parsed<List<CourseModel>>> getAllCourse() async {
    final list = <CourseModel>[];
    final file = await FileService.getJson(Filename.courses);
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    for (final data in json['data']['courses']) {
      list.add(CourseModel.fromJson(data));
    }
    return Parsed.fromJson(json, 200, list);
  }

  @override
  Future<Parsed<List<BookmarkModel>>> getAllBookmarkedCourse(
    String code,
  ) async {
    final list = <BookmarkModel>[];
    final file = await FileService.getJson('bookmarks.json');
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    for (final data in json['data']['bookmarks']) {
      list.add(BookmarkModel.fromJson(data));
    }
    return Parsed.fromJson(json, 200, list);
  }
}
