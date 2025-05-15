import 'package:dartz/dartz.dart';

abstract class BaseUseCase<TError, TInput, TOutput> {
  Future<Either<TError, TOutput>> call(TInput input);
}
