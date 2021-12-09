part of '_environment.dart';

class Endpoints {
  /// Base Endpoints.
  static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  static const localHost = 'http://127.0.0.1:8000';
  static const baseUrlDev = 'https://apidev-ulaskelas.ristek.cs.ui.ac.id';
  static const baseUrlProd = 'https://apidev-ulaskelas.ristek.cs.ui.ac.id';
  static final sso = '$baseUrl/login';
  static final ssoMobile = '$baseUrl/login/?redirect_url=${Endpoints.token}';
  static final token = '$baseUrl/token';
  static final users = '$baseUrl/users';
  static final userId = '$baseUrl/users/{{Id}}';
  static final review = '$baseUrl/api/reviews';
  static final courses = '$baseUrl/api/courses';
  static final bookmarks = '$baseUrl/api/bookmarks';
  static final tags = '$baseUrl/api/tags';
  static final likes = '$baseUrl/api/likes';
}
