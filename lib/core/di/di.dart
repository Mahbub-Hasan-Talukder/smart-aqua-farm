import 'package:get_it/get_it.dart';
import 'package:smart_aqua_farm/features/home/data/data/home_data_source.dart';
import 'package:smart_aqua_farm/features/home/data/data/home_data_source_imp.dart';
import 'package:smart_aqua_farm/features/home/data/repo_imp/home_repo_imp.dart';
import 'package:smart_aqua_farm/features/home/presentation/cubits/detection/detection_cubit.dart';
import 'package:smart_aqua_farm/features/library/data/data_source/library_data_source.dart';
import 'package:smart_aqua_farm/features/library/data/data_source/library_data_source_imp.dart';
import 'package:smart_aqua_farm/features/library/data/repository_imp/library_repo_imp.dart';
import 'package:smart_aqua_farm/features/library/domain/repository/library_repo.dart';
import 'package:smart_aqua_farm/features/library/domain/use_cases/library_use_cases.dart';
import 'package:smart_aqua_farm/features/library/presentation/cubits/dis_details/dis_details_cubit.dart';

import '../../features/auth/data/data_source/local/auth_local_imp.dart'
    show AuthLocalImpl;
import '../../features/auth/data/repository_impl/auth_reposity_impl.dart';
import '../../features/auth/presentation/cubits/auth/sign_in/google_sign_in_cubit.dart';
import '../../features/auth/presentation/cubits/auth/sign_in/sign_in_cubit.dart';
import '../../features/home/domain/repository/home_repo.dart'
    show HomeRepository;
import '../../features/home/domain/use_case/home_use_cases.dart';
import '../../features/library/presentation/cubits/fetch_dis/fetch_dis_cubit.dart';
import '../base/app_data/app_data.dart';
import '../../features/auth/data/data_source/local/auth_local.dart';
import '../../features/auth/data/data_source/remote/auth_remote.dart';
import '../../features/auth/data/data_source/remote/auth_remote_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/use_case/auth_use_case.dart';
import '../../features/auth/presentation/cubits/auth/forget_password/forget_pass_cubit.dart';
import '../../features/auth/presentation/cubits/auth/sign_up/sign_up_cubit.dart';
// import '../../features/home/data/data_source/local/home_local.dart';
// import '../../features/home/data/data_source/remote/home_remote.dart';
// import '../../features/home/data/data_source/remote/home_remote_imp.dart';
// import '../../features/home/presentation/cubits/create_project/create_project_cubit.dart';
// import '../../features/profile/data/data_source/profile_data_source.dart';
// import '../../features/profile/data/data_source/profile_data_source_impl.dart';
// import '../../features/profile/data/repo_impl/profile_repo_imp.dart';
// import '../../features/profile/domain/use_case/profile_fetch_use_case.dart';
// import '../../features/profile/presentation/cubits/profile_fetch_cubit.dart';
// import '../../features/project_details/data/data/remote/project_details_remote_imp.dart';
// import '../../features/project_details/data/repository_imp/project_details_repo_imp.dart';
// import '../../features/project_details/domain/repository/project_details_repo.dart';
// import '../../features/project_details/domain/use_case/project_details_use_case.dart';
// import '../../features/project_details/presentation/cubits/create_task/create_task_cubit.dart';
// import '../../features/auth/data/data_source/local/auth_local_imp.dart';
// import '../../features/auth/data/repository_impl/auth_reposity_impl.dart';
// import '../../features/auth/presentation/cubits/auth/sign_in/google_sign_in_cubit.dart';
// import '../../features/auth/presentation/cubits/auth/sign_in/sign_in_cubit.dart';
// import '../../features/home/data/data_source/local/home_local_impl.dart';
// import '../../features/home/data/repository_imp/home_repo_imp.dart';
// import '../../features/home/domain/repository/home_repository.dart';
// import '../../features/home/domain/use_cases/home_use_cases.dart';
// import '../../features/home/presentation/cubits/fetch_projects/fetch_projects_cubit.dart';
// import '../../features/home/presentation/cubits/fetch_user/fetch_user_cubit.dart';
// import '../../features/profile/domain/repository/profile_repo.dart';
// import '../../features/project_details/data/data/remote/project_details_remote.dart';
// import '../../features/project_details/presentation/cubits/delete_task/detele_task_cubit.dart';
// import '../../features/project_details/presentation/cubits/fetch_task/fetch_task_cubit.dart';
// import '../../features/project_details/presentation/cubits/fetch_tasks/fetch_tasks_cubit.dart';
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
  getIt.registerLazySingleton<AppData>(() => AppData());

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
  getIt.registerFactory<DetectionCubit>(() => DetectionCubit(getIt.call()));
  getIt.registerFactory<DisDetailsCubit>(() => DisDetailsCubit(getIt.call()));
  getIt.registerFactory<FetchDisCubit>(() => FetchDisCubit(getIt.call()));
  // getIt.registerCachedFactory<FetchProjectsCubit>(
  //     () => FetchProjectsCubit(getIt.call()));
  // getIt.registerCachedFactory<FetchUserCubit>(
  //     () => FetchUserCubit(getIt.call()));
  // getIt.registerCachedFactory<CreateProjectCubit>(
  //     () => CreateProjectCubit(getIt.call()));
  // getIt.registerFactory<CreateTaskCubit>(() => CreateTaskCubit(getIt.call()));
  // getIt.registerFactory<FetchTaskCubit>(() => FetchTaskCubit(getIt.call()));
  // getIt.registerFactory<FetchTasksCubit>(() => FetchTasksCubit(getIt.call()));
  // getIt.registerFactory<DeleteTaskCubit>(() => DeleteTaskCubit(getIt.call()));
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
  getIt.registerLazySingleton<DetectionUseCase>(
    () => DetectionUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<FetchDisUseCase>(
    () => FetchDisUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<DisDetUseCase>(() => DisDetUseCase(getIt.call()));
  // getIt.registerLazySingleton<FetchProjectsUseCase>(
  //     () => FetchProjectsUseCase(getIt.call()));
  // getIt.registerLazySingleton<FetchUserUseCase>(
  //     () => FetchUserUseCase(getIt.call()));
  // getIt.registerLazySingleton<CreateProjectUseCase>(
  //     () => CreateProjectUseCase(getIt.call()));
  // getIt.registerLazySingleton<CreateTaskUseCase>(
  //     () => CreateTaskUseCase(getIt.call()));
  // getIt.registerLazySingleton<FetchTaskUseCase>(
  //     () => FetchTaskUseCase(getIt.call()));
  // getIt.registerLazySingleton<FetchTasksUseCase>(
  //     () => FetchTasksUseCase(getIt.call()));
  // getIt.registerLazySingleton<DeleteTasksUseCase>(
  //     () => DeleteTasksUseCase(getIt.call()));
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
  // getIt.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl());
  // getIt.registerLazySingleton<HomeLocal>(() => HomeLocalImpl());
  // getIt.registerLazySingleton<ProjectDetailsRemote>(
  //     () => ProjectDetailsRemoteImp());
  // getIt.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl());
}
