import 'package:dartz/dartz.dart';

import '../entity/edit_profile_req.dart';
import '../entity/fetch_profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, FetchProfileEntity>> fetchProfile();
  Future<Either<String, bool>> editProfile(EditProfileReq reqEntity);
}
