import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entity/edit_profile_req.dart';
import '../../../../domain/use_case/profile_use_cases.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._editProfileUseCase) : super(EditProfileInitial());

  final EditProfileUseCase _editProfileUseCase;

  void editProfile(EditProfileReq editProfileReq) async {
    emit(EditProfileLoading());
    final res = await _editProfileUseCase.call(editProfileReq);
    res.fold(
      (error) => emit(EditProfileFailed(error: error)),
      (success) => emit(EditProfileSuccess(success: success)),
    );
  }
}
