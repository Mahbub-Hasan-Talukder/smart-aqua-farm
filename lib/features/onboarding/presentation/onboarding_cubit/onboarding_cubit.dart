import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_case/onboarding_use_case.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingUseCase onboardingUseCase;

  OnboardingCubit(this.onboardingUseCase) : super(OnboardingInitial());

  void getOnboardingStatus() async {
    if (state is OnboardingLoading) return;

    emit(OnboardingLoading());
    await Future.delayed(const Duration(milliseconds: 500));

    final onboardStatus = await onboardingUseCase.isOnboardingCompleted();

    onboardStatus.fold(
      (completed) {
        emit(OnboardingLoaded(completed));
      },
      (error) {
        emit(OnboardingError(error));
      },
    );
  }

  void setOnboardingCompleted() async {
    final response = await onboardingUseCase.setOnboardingCompleted();
    response.fold(
      (_) {
        emit(OnboardingLoaded(true));
      },
      (r) {
        emit(OnboardingError(r));
      },
    );
  }

  void checkSignInStatus() async {
    final response = await onboardingUseCase.checkSignedInStatus();
    response.fold(
      (l) {
        emit(LoggedInStatus(l));
      },
      (r) {
        emit(OnboardingError(r));
      },
    );
  }
}
