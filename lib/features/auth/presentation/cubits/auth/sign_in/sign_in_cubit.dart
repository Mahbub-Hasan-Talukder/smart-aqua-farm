import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_aqua_farm/core/logger/logger.dart';

import '../../../../../../core/io/failure.dart';
import '../../../../../../core/io/success.dart';
import '../../../../domain/entity/user_entity.dart';
import '../../../../domain/use_case/auth_use_case.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._signInUseCase) : super(SignInInitial());

  final SignInUseCase _signInUseCase;

  void signIn(UserEntity userInfo) async {
    emit(SignInLoading());
    final res = await _signInUseCase.call(userInfo);

    res.fold(
      (l) {
        logger.e(l.message);
        emit(SignInFailed(l));
      },
      (r) {
        emit(SignInSuccess(r));
      },
    );
  }
}
