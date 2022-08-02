part of '_environment.dart';

class Endpoints {
  /// Base Endpoints.
  static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  static const localHost = 'http://127.0.0.1:8000';
  static const baseUrlDev =
      'http://ulaskelas-dev1.ap-southeast-1.elasticbeanstalk.com';
  static const baseUrlProd = 'https://api-ulaskelas.ristek.cs.ui.ac.id';
  static final sso = '$baseUrl/login';
  static final ssoMobile = '$baseUrl/login/?redirect_url=${Endpoints.token}';
  static final token = '$baseUrl/token';
  static final account = '$baseUrl/api/account';
  static final userId = '$baseUrl/users/{{Id}}';
  static final review = '$baseUrl/api/reviews';
  static final courses = '$baseUrl/api/courses';
  static final bookmarks = '$baseUrl/api/bookmarks';
  static final tags = '$baseUrl/api/tags';
  static final likes = '$baseUrl/api/likes';
  static final course = '$baseUrl/api/courses/{courseId}';
  static final calculators = '$baseUrl/api/calculator';
  static final components = '$baseUrl/api/score-component';
}
