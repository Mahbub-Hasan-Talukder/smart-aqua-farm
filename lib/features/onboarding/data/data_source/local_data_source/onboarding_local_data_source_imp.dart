import 'package:dartz/dartz.dart';
import '../../../../../core/services/local/shared_preference_services.dart';
import '../../../../../core/di/di.dart';
import 'onboarding_local_data_source.dart';

final class OnboardingLocalDataSourceImp implements OnboardingLocalDataSource {
  @override
  Future<Either<bool, String>> isOnboardingCompleted() async {
    try {
      final prefs = getIt<SharedPreferenceService>();
      bool hasSeenOnboarding = await prefs.getBool('onboarding') ?? false;
      return Left(hasSeenOnboarding);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<void, String>> setOnboardingCompleted() async {
    try {
      final prefs = getIt<SharedPreferenceService>();
      await prefs.setBool('onboarding', true);
      return const Left(null);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
