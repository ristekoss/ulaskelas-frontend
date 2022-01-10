// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_datasources.dart';

abstract class CourseRemoteDataSource {
  Future<Parsed<List<CourseModel>>> getAllCourse(QuerySearchCourse querySearch);
  Future<Parsed<List<CourseModel>>> getCurrentTermCourse();
  Future<Parsed<CourseModel>> getDetailCourse(int courseId);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  @override
  Future<Parsed<List<CourseModel>>> getAllCourse(
    QuerySearchCourse querySearch,
  ) async {
    final list = <CourseModel>[];
    final url = '${Endpoints.courses}?$querySearch';
    final resp = await getIt(url);
    for (final data in resp.dataBodyAsMap['courses']) {
      list.add(CourseModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      const filename = Filename.courses;
      await FileService.saveJson(filename, jsonEncode(resp.data));
      await Pref.saveString(filename, DateTime.now().toIso8601String());
    }
    return resp.parse(list);
  }

  @override
  Future<Parsed<List<CourseModel>>> getCurrentTermCourse() async {
    final list = <CourseModel>[];
    final url = Endpoints.courses;
    final resp = await getIt(url);
    for (final data in resp.dataBodyAsMap['courses']) {
      list.add(CourseModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      final filename = 'current-semester-course.json';
      await FileService.saveJson(
        filename,
        jsonEncode(resp.data),
      );
    }
    return resp.parse(list);
  }

  @override
  Future<Parsed<CourseModel>> getDetailCourse(int courseId) async {
    final url = Endpoints.course.replaceAll('{courseId}', courseId.toString());
    final resp = await getIt(url);
    return resp.parse(CourseModel.fromJson(resp.dataBodyAsMap['course']));
  }
}
