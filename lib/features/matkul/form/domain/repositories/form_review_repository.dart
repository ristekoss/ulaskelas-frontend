part of '_repositories.dart';

abstract class FormReviewRepository {
  Future<Decide<Failure, Parsed<ReviewNewModel>>> createReview(
      Map<String, dynamic> model);
}
