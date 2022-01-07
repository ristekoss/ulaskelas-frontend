import 'package:logger/logger.dart';
import 'package:ulaskelas/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:ulaskelas/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ulaskelas/features/profile/data/models/profile_model.dart';
import 'package:ulaskelas/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:ulaskelas/features/profile/domain/entities/profile_repository.dart';

class ProfileState {
  ProfileState() {
    final _remoteDataSource = ProfileRemoteDataSourceImpl();
    final _localDataSource = ProfileLocalDataSourceImpl();
    _repo = ProfileRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }
  ProfileRepository? _repo;

  ProfileModel? _profile;
  ProfileModel get profile => _profile ?? ProfileModel();

  Future<void> retrieveData() async {
    final resp = await _repo?.getProfile();
    resp?.fold(
      (failure) {
        Logger().e(failure.message);
        // if(failure is UnAuthorizeFailure) {
        //   while(nav.canPop()) {
        //     nav.pop();
        //   }
        //   nav.replaceToSsoPage();
        // }
      },
      (result) => _profile = result.data,
    );
  }
}
