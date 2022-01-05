import 'package:ulaskelas/core/client/_client.dart';
import 'package:ulaskelas/core/error/_error.dart';
import 'package:ulaskelas/core/extension/_extension.dart';
import 'package:ulaskelas/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:ulaskelas/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ulaskelas/features/profile/data/models/profile_model.dart';
import 'package:ulaskelas/features/profile/domain/entities/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;

  ProfileRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Decide<Failure, Parsed<ProfileModel>>> getProfile() {
    return apiCall(_remoteDataSource.getProfile());
  }

  Future<void> hidden() async {
    _localDataSource.toString();
  }
}
