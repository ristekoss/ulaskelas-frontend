# 👨‍💻 Ulas Kelas Back End & Data Communication

Ulas Kelas Communication with application programming interface

## ⚡️ Getting Started

### Define API endpoints

Add endpoint to this class
example at lib/core/environment/endpoints.dart
```dart
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
}
```

### Create Data Source & Repository

example at lib/features/matkul/search/data/datasources/matkul_remote_data_source.dart
```dart
abstract class MatkulRemoteDataSource {}

class MatkulRemoteDataSourceImpl implements MatkulRemoteDataSource {}
```

example at lib/features/matkul/search/domain/repositores/matkul_repository.dart
```dart
abstract class MatkulRepository {}
```

example at lib/features/matkul/search/data/repositores/matkul_repository_impl.dart
```dart
class MatkulRepositoryImpl implements MatkulRepository {}
```