part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  final bool onboardComplete;
  const OnboardingLoaded(this.onboardComplete);
  @override
  List<Object> get props => [onboardComplete];
}

final class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object> get props => [message];
}

final class LoggedInStatus extends OnboardingState {
  final bool isSignedIn;
  const LoggedInStatus(this.isSignedIn);
  @override
  List<Object> get props => [isSignedIn];
}
