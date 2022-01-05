import 'package:ulaskelas/core/error/_error.dart';
import 'package:ulaskelas/core/extension/_extension.dart';
import 'package:ulaskelas/features/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<Decide<Failure, Parsed<ProfileModel>>> getProfile();
}
