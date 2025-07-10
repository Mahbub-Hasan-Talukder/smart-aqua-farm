import 'package:dartz/dartz.dart';

import '../../../../../core/services/local/hive_services.dart';
import '../../../../../core/di/di.dart';
import 'onboarding_local_data_source.dart';

final class OnboardingLocalDataSourceImp implements OnboardingLocalDataSource {
  @override
  Future<Either<bool, String>> isOnboardingCompleted() async {
    try {
      final hive = getIt<HiveServices>();
      bool hasSeenOnboarding =
          await hive.getValue<bool>(
            key: 'onboarded',
            boxName: HiveServices.onBoardBox,
          ) ??
          false;
      return Left(hasSeenOnboarding);
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<void, String>> setOnboardingCompleted() async {
    try {
      final hive = getIt<HiveServices>();
      await hive.setValue(
        key: 'onboarded',
        value: true,
        boxName: HiveServices.onBoardBox,
      );
      return const Left(null);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
