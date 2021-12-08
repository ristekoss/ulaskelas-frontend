part of '_repositories.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final ReviewRemoteDataSource _remoteDataSource;
  final ReviewLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllReview() {
    return apiCall(_remoteDataSource.getAllReview());
  }

  @override
  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllReviewFromCache() {
    return apiCall(_localDataSource.getAllReview());
  }
}
