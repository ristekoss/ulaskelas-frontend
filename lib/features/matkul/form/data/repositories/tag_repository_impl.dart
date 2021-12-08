part of '_repositories.dart';

class TagRepositoryImpl implements TagRepository {
  TagRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final TagRemoteDataSource _remoteDataSource;
  final TagLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<TagModel>>>> getAllTag() {
    return apiCall(_remoteDataSource.getAllTag());
  }

  @override
  Future<Decide<Failure, Parsed<List<TagModel>>>> getAllTagFromCache() {
    return apiCall(_localDataSource.getAllTag());
  }
}
