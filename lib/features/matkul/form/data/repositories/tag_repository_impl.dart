part of '_repositories.dart';

class TagRepositoryImpl implements TagRepository {
  TagRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final TagRemoteDataSource _remoteDataSource;
  final TagLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<String>>>> getAllTag(
    QuerySearchTag query,
  ) {
    return apiCall(_remoteDataSource.getAllTag(query));
  }

  @override
  Future<Decide<Failure, Parsed<List<String>>>> getAllTagFromCache() {
    return apiCall(_localDataSource.getAllTag());
  }
}
