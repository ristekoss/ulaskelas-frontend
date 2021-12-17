part of '_repositories.dart';

abstract class LikeRepository {
  Future<dynamic> like(ReviewModel review);
  Future<dynamic> unlike(ReviewModel review);
}
