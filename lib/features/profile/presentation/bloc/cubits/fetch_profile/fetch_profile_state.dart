part of 'fetch_profile_cubit.dart';

class FetchProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProfileSuccess extends FetchProfileState {
  final FetchProfileEntity fetchProfileEntity;
  FetchProfileSuccess(this.fetchProfileEntity);

  @override
  List<Object?> get props => [fetchProfileEntity];
}

class FetchProfileFailed extends FetchProfileState {
  final String error;
  FetchProfileFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class FetchProfileLoading extends FetchProfileState {}

class FetchProfileInitial extends FetchProfileState {}
