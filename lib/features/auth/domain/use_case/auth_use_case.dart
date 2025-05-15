import 'package:dartz/dartz.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../../../../core/base/use_case/base_use_case.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart' show AuthRepository;

class SignUpUseCase extends BaseUseCase<UserEntity, Failure, Success> {
  final AuthRepository _authRepository;
  SignUpUseCase(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(UserEntity input) async {
    return await _authRepository.signUp(input);
  }
}

class SignInUseCase extends BaseUseCase<UserEntity, Failure, Success> {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(UserEntity input) async {
    return await _authRepository.signIn(input);
  }
}

class GoogleSignInUseCase extends BaseUseCase<void, Failure, Success> {
  final AuthRepository _authRepository;
  GoogleSignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(void input) async {
    return await _authRepository.signInWithGoogle();
  }
}

class ForgetPasswordUseCase extends BaseUseCase<String, Failure, Success> {
  final AuthRepository _authRepository;
  ForgetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, Success>> call(String input) async {
    return await _authRepository.forgetPassword(input);
  }
}
