part of '../../_environment.dart';

class EndpointsV1 {
  /// Base Endpoints.
  static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  static final account = '$baseUrl/api/v1/account';
  static final review = '$baseUrl/api/v1/reviews';
  static final courses = '$baseUrl/api/v1/courses';
  static final bookmarks = '$baseUrl/api/v1/bookmarks';
  static final tags = '$baseUrl/api/v1/tags';
  static final likes = '$baseUrl/api/v1/likes';
  static final course = '$baseUrl/api/v1/courses/{courseId}';
  static final leaderboard = '$baseUrl/api/v1/leaderboard';
  static final calculators = '$baseUrl/api/v1/calculator';
  static final components = '$baseUrl/api/v1/score-component';
}
