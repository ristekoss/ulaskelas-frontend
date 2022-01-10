// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_repositories.dart';

abstract class CourseRepository {
  Future<Decide<Failure, Parsed<List<CourseModel>>>> getAllCourse(
    QuerySearchCourse querySearch,
  );

  Future<Decide<Failure, Parsed<List<CourseModel>>>> getCurrentTermCourse();

  Future<Decide<Failure, Parsed<List<CourseModel>>>> getAllCachedCourse();
  Future<Decide<Failure, Parsed<CourseModel>>> getDetailCourse(int courseId);
}
