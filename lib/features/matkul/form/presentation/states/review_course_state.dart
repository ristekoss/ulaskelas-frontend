// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_states.dart';

class ReviewCourseState {
  ReviewCourseState() {
    final _remoteDataSource = ReviewRemoteDataSourceImpl();
    final _localDataSource = ReviewLocalDataSourceImpl();
    _repo = ReviewRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  late ReviewRepository _repo;
  List<ReviewModel>? _reviews;
  List<ReviewModel> get reviews => _reviews!;

  /// Retrieving review
  Future<void> retrieveData(QueryReview q) async {
    final resp = await _repo.getAllReview(q);
    resp.fold((failure) {
      if (failure is NetworkFailure) {
        retrieveFromCache(q);
      } else {
        throw failure;
      }
    }, (result) {
      _reviews = result.data;
    });
  }

  Future<void> retrieveFromCache(QueryReview q) async {
    final resp = await _repo.getAllCachedReview(q);
    resp.fold((failure) {
      throw failure;
    }, (result) {
      _reviews = result.data;
    });
  }
}
