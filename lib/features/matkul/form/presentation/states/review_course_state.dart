// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_states.dart';

class ReviewCourseState {
  ReviewCourseState() {
    final remoteDataSource = ReviewRemoteDataSourceImpl();
    final localDataSource = ReviewLocalDataSourceImpl();
    _repo = ReviewRepositoryImpl(
      remoteDataSource,
      localDataSource,
    );
    final likeRemoteDataSource = LikeRemoteDataSourceImpl();
    _likeRepo = LikeRepositoryImpl(likeRemoteDataSource);
  }

  late ReviewRepository _repo;
  late LikeRepository _likeRepo;
  List<ReviewModel>? _reviews;
  List<ReviewModel>? _myReviews;
  List<ReviewModel> get reviews => _reviews!;
  List<ReviewModel> get myReviews => _myReviews!;

  int page = 1;
  bool hasReachedMax = false;

  /// Retrieving review
  Future<void> retrieveData(QueryReview q) async {
    await Future.wait([
      retrieveOtherReview(q),
      retrieveMyReview(q),
    ]);
  }

  Future<void> retrieveOtherReview(QueryReview q) async {
    page = 1;
    q.page = page;
    final resp = await _repo.getAllReview(q);
    resp.fold((failure) {
      if (failure is NetworkFailure) {
        retrieveFromCache(q);
      } else {
        throw failure;
      }
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
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
      // Prevent duplicate record
      _myReviews = result.data;
    });
  }

  Future<void> retrieveMoreData(QueryReview query) async {
    ++page;
    query.page = page;
    final resp = await _repo.getAllReview(query);
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;

      // Prevent duplicate record
      filterReview(result.data);
    });
  }

  void filterReview(List<ReviewModel> reviews) {
    _myReviews ??= reviews;
    for (final review in reviews) {
      if (!(_myReviews?.contains(review) ?? true)) {
        _myReviews?.add(review);
      }
    }
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
    MixpanelService.track(
      'like_review',
      params: {
        'course_id': review.courseCode.toString(),
        'course_name': review.courseName.toString(),
        'review_count': review.likesCount.toString(),
        'course_rating_avg': review.ratingAverage.toString(),
      },
    );
  }
}
