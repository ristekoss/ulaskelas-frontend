// Created by Muhamad Fauzi Ridwan on 27/12/21.

part of '_states.dart';

class CurrentTermCourseState {
  CurrentTermCourseState() {
    final _remoteDataSource = CourseRemoteDataSourceImpl();
    final _localDataSource = CourseLocalDataSourceImpl();
    _repo = CourseRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  CourseRepository? _repo;

  List<CourseModel>? _courses;
  List<CourseModel> get courses => _courses!;
  List<CourseModel> get summaries =>
      _courses!.sublist(0, min(_courses!.length, 3));
  bool get hasCourse => _courses?.isNotEmpty ?? false;

  Future<void> retrieveData() async {
    print('loading');
    final resp = await _repo?.getCurrentTermCourse();
    resp?.fold(
      (failure) {
        throw failure;
      },
      (result) => _courses = result.data,
    );
  }
}
