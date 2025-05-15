import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_case/onboarding_use_case.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingUseCase onboardingUseCase;

  OnboardingCubit(this.onboardingUseCase) : super(OnboardingInitial());

  void getOnboardingStatus() async {
    emit(OnboardingLoading());
    await Future.delayed(const Duration(seconds: 1));

    final onboardStatus = await onboardingUseCase.isOnboardingCompleted();

    onboardStatus.fold(
      (l) {
        emit(OnboardingLoaded(l));
      },
      (r) {
        emit(OnboardingError(r));
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
