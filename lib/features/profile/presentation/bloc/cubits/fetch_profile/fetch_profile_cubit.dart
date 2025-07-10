import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/io/no_input.dart';
import '../../../../domain/entity/fetch_profile_entity.dart';
import '../../../../domain/use_case/profile_use_cases.dart';

part 'fetch_profile_state.dart';

class FetchProfileCubit extends Cubit<FetchProfileState> {
  FetchProfileCubit(this._fetchProfileUseCase) : super(FetchProfileInitial());

  final FetchProfileUseCase _fetchProfileUseCase;

  void fetchProfile() async {
    emit(FetchProfileLoading());
    final res = await _fetchProfileUseCase.call(NoInput());
    res.fold(
      (error) => emit(FetchProfileFailed(error)),
      (profileData) => emit(FetchProfileSuccess(profileData)),
    );
  }
}
