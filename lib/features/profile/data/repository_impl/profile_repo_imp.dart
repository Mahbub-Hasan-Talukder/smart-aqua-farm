import 'package:dartz/dartz.dart';

import '../data_source/remote/profile_remote_source.dart';
import '../model/fetch_profile_response.dart';
import '../../domain/entity/edit_profile_req.dart';
import '../../domain/entity/fetch_profile_entity.dart';
import '../../domain/repository/profile_repository.dart';

class ProfileRepoImp implements ProfileRepository {
  final ProfileRemoteSource _profileRemoteSource;
  ProfileRepoImp(this._profileRemoteSource);
  @override
  Future<Either<String, bool>> editProfile(EditProfileReq reqEntity) async {
    try {
      await _profileRemoteSource.editProfile(reqEntity.toJson());
      return Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, FetchProfileEntity>> fetchProfile() async {
    try {
      final res = await _profileRemoteSource.fetchProfile();
      return Right(FetchProfileResponse.fromJson(res).toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
