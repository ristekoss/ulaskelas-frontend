part of '_repositories.dart';

class LikeRepositoryImpl implements LikeRepository {
  LikeRepositoryImpl(
    this._remoteDataSource,
  );

  final LikeRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<String>>> like(ReviewModel review) {
    return apiCall(_remoteDataSource.like(review));
  }

  @override
  Future<Decide<Failure, Parsed<String>>> unlike(ReviewModel review) {
    return apiCall(_remoteDataSource.unlike(review));
  }
}
