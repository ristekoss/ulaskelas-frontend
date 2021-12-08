part of '_repositories.dart';

abstract class ReviewRepository {
  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllReview();
  Future<Decide<Failure, Parsed<List<ReviewModel>>>> getAllReviewFromCache();
}
