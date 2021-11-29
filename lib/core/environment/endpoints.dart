part of '_environment.dart';

class Endpoints {
  ///Base Endpoints
  // static String baseUrl = Config.baseConfig.endpoints.baseUrl;
  static String baseUrl = localHost;
  static const localHost = 'http://127.0.0.1:8000';
  static const baseUrlDev =
      'http://ulaskelas-dev.ap-southeast-1.elasticbeanstalk.com';
  static const baseUrlProd =
      'http://ulaskelas-dev.ap-southeast-1.elasticbeanstalk.com';
  static final sso = '$baseUrl/login';
  static final users = '$baseUrl/users';
  static final userId = '$baseUrl/users/{{Id}}';
  static final review = '$baseUrl/reviews';
  static final token = '$baseUrl/token';
}
