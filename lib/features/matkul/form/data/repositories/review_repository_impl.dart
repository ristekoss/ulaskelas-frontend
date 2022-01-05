part of '_repositories.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final ReviewRemoteDataSource _remoteDataSource;
  final ReviewLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<ReviewModel>>> createReview(
    Map<String, dynamic> model,
  ) async {
    return apiCall(_remoteDataSource.createReview(model));
  }

  @override
  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllCachedReview(
    QueryReview q,
  ) {
    return apiCall(_localDataSource.getAllCachedReview(q));
  }

  @override
  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllReview(
    QueryReview q,
  ) {
    return apiCall(_remoteDataSource.getAllReview(q));
  }
}
