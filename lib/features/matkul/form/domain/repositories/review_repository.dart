part of '_repositories.dart';

abstract class ReviewRepository {
  Future<Decide<Failure, Parsed<ReviewModel>>> createReview(
    Map<String, dynamic> model,
  );

  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllReview(
    QueryReview q,
  );

  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllCachedReview(
    QueryReview q,
  );
}
