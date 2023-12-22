// Created by Muhamad Fauzi Ridwan on 27/12/21.

part of '_states.dart';

class ReviewHistoryState {
  ReviewHistoryState() {
    final remoteDataSource = ReviewRemoteDataSourceImpl();
    final localDataSource = ReviewLocalDataSourceImpl();
    _repo = ReviewRepositoryImpl(
      remoteDataSource,
      localDataSource,
    );
  }

  late ReviewRepository _repo;

  int page = 1;
  bool hasReachedMax = false;

  List<ReviewModel>? _reviewHistories;
  List<ReviewModel> get reviewHistories => _reviewHistories!;
  List<ReviewModel> get summaries =>
      _reviewHistories!.sublist(0, min(_reviewHistories!.length, 3));

  Future<void> retrieveData(QueryReview q) async {
    page = 1;
    q.page = 1;
    final resp = await _repo.getAllReview(q);
    resp.fold((failure) {
      if (failure is NetworkFailure) {
        // retrieveFromCache(q);
      } else {
        throw failure;
      }
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _reviewHistories = result.data;
    });
  }

  Future<void> retrieveMoreData(QueryReview q) async {
    ++page;
    q.page = page;
    final resp = await _repo.getAllReview(q);
    resp.fold((failure) {
      if (failure is NetworkFailure) {
        // retrieveFromCache(q);
      } else {
        throw failure;
      }
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _reviewHistories?.addAll(result.data);
    });
  }
}
