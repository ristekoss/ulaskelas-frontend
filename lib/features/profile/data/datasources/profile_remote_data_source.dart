import 'package:ulaskelas/core/client/_client.dart';
import 'package:ulaskelas/core/environment/_environment.dart';
import 'package:ulaskelas/core/extension/_extension.dart';
import 'package:ulaskelas/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Parsed<ProfileModel>> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<Parsed<ProfileModel>> getProfile() async {
    final url = EndpointsV1.account;
    final resp = await getIt(url);
    return resp.parse(ProfileModel.fromJson(resp.dataBodyAsMap));
  }
}
