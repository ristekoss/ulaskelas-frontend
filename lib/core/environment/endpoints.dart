part of '_environment.dart';

class Endpoints {
  /// Base Endpoints.
  static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  static const baseUrlDev = Secret.baseUrlDev;
  static const baseUrlProd = Secret.baseUrlProd;
  static const localHost = 'http://127.0.0.1:8000';
  static final sso = '$baseUrl/login';
  static final ssoMobile = '$baseUrl/login/?redirect_url=${Endpoints.token}';
  static final token = '$baseUrl/token';
  static final userId = '$baseUrl/users/{{Id}}';
  static final account = '$baseUrl/api/account';
  static final review = '$baseUrl/api/reviews';
  static final courses = '$baseUrl/api/courses';
  static final bookmarks = '$baseUrl/api/bookmarks';
  static final tags = '$baseUrl/api/tags';
  static final likes = '$baseUrl/api/likes';
  static final course = '$baseUrl/api/courses/{courseId}';
  static final leaderboard = '$baseUrl/api/leaderboard';
  static final calculators = '$baseUrl/api/calculator';
  static final components = '$baseUrl/api/score-component';
}
