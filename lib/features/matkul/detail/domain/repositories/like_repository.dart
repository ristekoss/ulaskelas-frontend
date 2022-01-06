part of '_repositories.dart';

abstract class LikeRepository {
  Future<Decide<Failure, Parsed<String>>> like(ReviewModel review);
  Future<Decide<Failure, Parsed<String>>> unlike(ReviewModel review);
}
