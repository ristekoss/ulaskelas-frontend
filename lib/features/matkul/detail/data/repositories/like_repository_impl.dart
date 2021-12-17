part of '_repositories.dart';

class LikeRepositoryImpl implements LikeRepository {
  LikeRepositoryImpl(
    this._remoteDataSource,
  );

  final LikeRemoteDataSource _remoteDataSource;

  @override
  Future<void> like(ReviewModel review) {
    return apiCall(_remoteDataSource.like(review));
  }

  @override
  Future unlike(ReviewModel review) {
    return apiCall(_remoteDataSource.like(review));
  }
}
