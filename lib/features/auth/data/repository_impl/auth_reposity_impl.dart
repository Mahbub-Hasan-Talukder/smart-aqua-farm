import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/io/failure.dart';
import '../../../../core/io/success.dart';
import '../data_source/local/auth_local.dart';
import '../data_source/remote/auth_remote.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';

class AuthReposityImpl implements AuthRepository {
  final AuthRemote _authRemoteDataSource;
  final AuthLocal _authLocalDataSource;

  AuthReposityImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Failure, Success>> signIn(UserEntity userInfo) async {
    try {
      final response = await _authRemoteDataSource.signIn(userInfo.toJson());
      if (response.user?.id == null) {
        return Left(Failure('User not found'));
      }
      final userData = await _authRemoteDataSource.getUser(
        response.user!.id,
      ); //id can't be null
      await _authLocalDataSource.saveUser(userData);
      return Right(Success('User Successfully signed in'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> signUp(UserEntity userInfo) async {
    try {
      final user = await _authRemoteDataSource.signUp(userInfo);
      if (user == null) {
        return Left(Failure('User not found'));
      }
      userInfo.id = user.id;
      await _authRemoteDataSource.addUser(userInfo);
      return Right(Success('Verification email is sent.'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> signInWithGoogle() async {
    try {
      final response = await _authRemoteDataSource.signInWithGoogle();
      if (response.user == null) {
        return Left(Failure('User not found'));
      }
      await _authRemoteDataSource.addUser(
        UserEntity(
          id: response.user!.id,
          email: response.user!.email ?? '',
          name:
              response.user!.userMetadata?['full_name']?.toString() ??
              'Unknown',
          profilePictureUrl:
              response.user!.userMetadata?['picture']?.toString() ?? '',
        ),
      );
      final userData = await _authRemoteDataSource.getUser(
        response.user!.email ?? '',
      );
      await _authLocalDataSource.saveUser(userData);
      return Right(Success('User successfully signed in with Google'));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error signing in with Google: $e');
      }
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> sendOtp(String email) async {
    try {
      await _authRemoteDataSource.forgetPassword(email);
      return Right(Success('OTP sent to your email'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> resetPass(
    Map<String, dynamic> payload,
  ) async {
    try {
      await _authRemoteDataSource.resetPass(payload);
      return Right(Success('Reset password successful.'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
