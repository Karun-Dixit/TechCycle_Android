import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sprint1/app/shared_prefs/token_shared_prefs.dart';
import 'package:sprint1/core/network/api_service.dart';
import 'package:sprint1/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:sprint1/features/auth/data/repository/auth_remote_repository.dart';
import 'package:sprint1/features/auth/domain/use_case/upload_image_usecase.dart';

// import 'package:sprint1/features/auth/domain/use_case/upload_image_usecase.dart';

import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import '../../features/auth/data/repository/auth_local_repository.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_user_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/signup/register_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  // await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use usecase
  // getIt.registerLazySingleton<RegisterUseCase>(
  //   () => RegisterUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );
}

// _initSplashScreenDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<LoginBloc>()),
//   );
// }
