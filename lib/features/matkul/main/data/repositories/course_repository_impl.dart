// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_repositories.dart';

class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final CourseRemoteDataSource _remoteDataSource;
  final CourseLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<CourseModel>>>> getAllCourse(
    QuerySearchCourse querySearch,
  ) {
    return apiCall(_remoteDataSource.getAllCourse(querySearch));
  }

  @override
  Future<Decide<Failure, Parsed<List<CourseModel>>>> getCurrentTermCourse() {
    return apiCall(_remoteDataSource.getCurrentTermCourse());
  }

  @override
  Future<Decide<Failure, Parsed<List<CourseModel>>>> getAllCachedCourse() {
    return apiCall(_localDataSource.getAllCourse());
  }
}
