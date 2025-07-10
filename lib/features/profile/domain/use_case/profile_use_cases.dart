import 'package:dartz/dartz.dart';

import '../entity/edit_profile_req.dart';
import '../repository/profile_repository.dart';
import '../../../../core/io/no_input.dart';
import '../entity/fetch_profile_entity.dart';
import '../../../../core/base/use_case/base_use_case.dart';

class FetchProfileUseCase
    extends BaseUseCase<String, NoInput, FetchProfileEntity> {
  FetchProfileUseCase(this._profileRepository);
  final ProfileRepository _profileRepository;
  @override
  Future<Either<String, FetchProfileEntity>> call(NoInput input) async {
    return await _profileRepository.fetchProfile();
  }
}

class EditProfileUseCase extends BaseUseCase<String, EditProfileReq, bool> {
  EditProfileUseCase(this._profileRepository);
  final ProfileRepository _profileRepository;
  @override
  Future<Either<String, bool>> call(EditProfileReq input) async {
    return await _profileRepository.editProfile(input);
  }
}
