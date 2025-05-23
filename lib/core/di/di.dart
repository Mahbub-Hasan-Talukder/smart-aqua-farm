import 'package:get_it/get_it.dart';

import '../services/firebase_service/firebase_setup.dart';
import '../services/firebase_service/firebase_setup_imp.dart';
import '../../features/auth/presentation/cubits/auth/reset_password/reset_pass_cubit.dart';
import '../../features/home/data/data/home_data_source.dart';
import '../../features/home/data/data/home_data_source_imp.dart';
import '../../features/home/data/repo_imp/home_repo_imp.dart';
import '../../features/home/presentation/cubits/detection/detection_cubit.dart';
import '../../features/library/data/data_source/library_data_source.dart';
import '../../features/library/data/data_source/library_data_source_imp.dart';
import '../../features/library/data/repository_imp/library_repo_imp.dart';
import '../../features/library/domain/repository/library_repo.dart';
import '../../features/library/domain/use_cases/library_use_cases.dart';
import '../../features/library/presentation/cubits/dis_details/dis_details_cubit.dart';
import '../../features/auth/data/data_source/local/auth_local_imp.dart';
import '../../features/auth/data/repository_impl/auth_reposity_impl.dart';
import '../../features/auth/presentation/cubits/auth/sign_in/google_sign_in_cubit.dart';
import '../../features/auth/presentation/cubits/auth/sign_in/sign_in_cubit.dart';
import '../../features/home/domain/repository/home_repo.dart';
import '../../features/home/domain/use_case/home_use_cases.dart';
import '../../features/library/presentation/cubits/fetch_dis/fetch_dis_cubit.dart';
import '../../features/auth/data/data_source/local/auth_local.dart';
import '../../features/auth/data/data_source/remote/auth_remote.dart';
import '../../features/auth/data/data_source/remote/auth_remote_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/use_case/auth_use_case.dart';
import '../../features/auth/presentation/cubits/auth/forget_password/forget_pass_cubit.dart';
import '../../features/auth/presentation/cubits/auth/sign_up/sign_up_cubit.dart';
import '../services/auth_service/auth_service.dart';
import '../services/auth_service/supabase_impl.dart';
import '../../features/onboarding/presentation/onboarding_cubit/onboarding_cubit.dart';
import '../../features/onboarding/data/data_source/local_data_source/onboarding_local_data_source.dart';
import '../../features/onboarding/data/data_source/local_data_source/onboarding_local_data_source_imp.dart';
import '../../features/onboarding/data/data_source/remote_data_source/onboarding_remote_data_source.dart';
import '../../features/onboarding/data/data_source/remote_data_source/onboarding_remote_data_source_imp.dart';
import '../../features/onboarding/data/repository_imp/onboarding_repo_imp.dart';
import '../../features/onboarding/domain/repository/onboarding_repository.dart';
import '../../features/onboarding/domain/use_case/onboarding_use_case.dart';
import '../base/cubit/base_cubit.dart';
import '../base/cubit/base_state.dart';
import '../services/local/shared_preference_services.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<BaseCubit>(() => BaseCubit(BaseState()));
  getIt.registerLazySingleton<SharedPreferenceService>(
    () => SharedPreferenceService(),
  );
  getIt.registerLazySingleton<AuthService>(() => SupabaseImpl());
  getIt.registerLazySingleton<FirebaseSetup>(() => FirebaseSetupImp());

  /// Register Cubits
  getIt.registerFactory(() => OnboardingCubit(getIt.call()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt.call()));
  getIt.registerFactory<SignInCubit>(() => SignInCubit(getIt.call()));
  getIt.registerFactory<GoogleSignInCubit>(
    () => GoogleSignInCubit(getIt.call()),
  );
  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt.call()),
  );
  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(getIt.call()),
  );
  getIt.registerFactory<DetectionCubit>(() => DetectionCubit(getIt.call()));
  getIt.registerFactory<DisDetailsCubit>(() => DisDetailsCubit(getIt.call()));
  getIt.registerFactory<FetchDisCubit>(() => FetchDisCubit(getIt.call()));
  // getIt.registerFactory<ProfileFetchCubit>(
  //     () => ProfileFetchCubit(getIt.call(), getIt.call()));

  // ///Register UseCases
  getIt.registerLazySingleton<OnboardingUseCase>(
    () => OnboardingUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(getIt.call()));
  getIt.registerLazySingleton<SignInUseCase>(() => SignInUseCase(getIt.call()));
  getIt.registerLazySingleton<GoogleSignInUseCase>(
    () => GoogleSignInUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<DetectionUseCase>(
    () => DetectionUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<FetchDisUseCase>(
    () => FetchDisUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<DisDetUseCase>(() => DisDetUseCase(getIt.call()));
  // getIt.registerLazySingleton<ProfileFetchUseCase>(
  //     () => ProfileFetchUseCase(getIt.call()));
  // getIt.registerLazySingleton<UpdateProfileUseCase>(
  //     () => UpdateProfileUseCase(getIt.call()));

  /// Register Repositories
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepoImp(getIt.call(), getIt.call()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthReposityImpl(getIt.call(), getIt.call()),
  );
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepoImp(getIt.call()));
  getIt.registerLazySingleton<LibraryRepository>(
    () => LibraryRepoImp(getIt.call()),
  );
  // getIt.registerLazySingleton<HomeRepository>(
  //     () => HomeRepositoryImpl(getIt.call(), getIt.call()));
  // getIt.registerLazySingleton<ProjectDetailsRepo>(
  //     () => ProjectDetailsRepoImp(getIt.call()));
  // getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImp(getIt.call()));

  /// Register DataSources
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImp(),
  );
  getIt.registerLazySingleton<OnboardingRemoteDataSource>(
    () => OnboardingRemoteDataSourceImp(),
  );
  getIt.registerLazySingleton<AuthRemote>(() => AuthRemoteImpl());
  getIt.registerLazySingleton<AuthLocal>(() => AuthLocalImpl());
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImp());
  getIt.registerLazySingleton<LibraryDataSource>(() => LibraryDataSourceImp());
}
