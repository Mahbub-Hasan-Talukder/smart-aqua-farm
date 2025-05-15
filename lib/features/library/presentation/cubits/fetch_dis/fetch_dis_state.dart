part of 'fetch_dis_cubit.dart';

class FetchDisState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDisInitial extends FetchDisState {}

final class FetchDisLoading extends FetchDisState {}

final class FetchDisSuccess extends FetchDisState {
  final List<DiseaseEntity> diseases;
  FetchDisSuccess({required this.diseases});
  @override
  List<Object?> get props => [diseases];
}

final class FetchDisFailure extends FetchDisState {
  final String error;
  FetchDisFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
