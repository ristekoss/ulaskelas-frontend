import 'package:ulaskelas/features/matkul/main/data/datasources/_datasources.dart';
import 'package:ulaskelas/features/matkul/main/data/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/main/domain/repositories/_repositories.dart';
import 'package:ulaskelas/features/matkul/search/data/models/_models.dart';

class CourseDetailState {
  CourseDetailState() {
    final _remoteDataSource = CourseRemoteDataSourceImpl();
    final _localDataSource = CourseLocalDataSourceImpl();
    _repo = CourseRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  late CourseRepository _repo;
  CourseModel? _detailCourse;
  CourseModel get detailCourse => _detailCourse!;

  Future<void> retrieveData(int courseId) async {
    final resp = await _repo.getDetailCourse(courseId);
    resp.fold((failure) => throw failure, (result) {
      _detailCourse = result.data;
    });
  }
}
