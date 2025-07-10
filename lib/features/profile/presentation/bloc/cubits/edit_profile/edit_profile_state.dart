part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileSuccess extends EditProfileState {
  final bool success;
  EditProfileSuccess({required this.success});

  @override
  List<Object?> get props => [success];
}

class EditProfileFailed extends EditProfileState {
  final String error;
  EditProfileFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}
