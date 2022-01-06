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
    final _likeRemoteDataSource = LikeRemoteDataSourceImpl();
    _likeRepo = LikeRepositoryImpl(_likeRemoteDataSource);
  }

  late ReviewRepository _repo;
  late LikeRepository _likeRepo;
  List<ReviewModel>? _reviews;
  List<ReviewModel>? _myReviews;
  List<ReviewModel> get reviews => _reviews!;
  List<ReviewModel> get myReviews => _myReviews!;

  /// Retrieving review
  Future<void> retrieveData(QueryReview q) async {
    await Future.wait([
      retrieveOtherReview(q),
      retrieveMyReview(q),
    ]);
  }

  Future<void> retrieveOtherReview(QueryReview q) async {
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

  Future<void> retrieveMyReview(QueryReview q) async {
    final query = q..byAuthor = true;
    final resp = await _repo.getAllReview(query);
    resp.fold((failure) {
      if (failure is NetworkFailure) {
        retrieveFromCache(q);
      } else {
        throw failure;
      }
    }, (result) {
      _myReviews = result.data;
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

  Future<void> like(ReviewModel review) async {
    (review.isLiked ?? false
            ? await _likeRepo.unlike(review)
            : await _likeRepo.like(review))
        .fold((failure) => Logger().e(failure.message), (result) {
      if (review.isLiked ?? false) {
        review.isLiked = false;
        review.likesCount--;
      } else {
        review.isLiked = true;
        review.likesCount++;
      }
      reviewCourseRM.notify();
    });
  }
}
