import 'package:dio/dio.dart';
import 'package:flutter/material.dart'; // Added for WidgetsFlutterBinding
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/app/constants/api_endpoints.dart';
import 'package:sprint1/app/shared_prefs/token_shared_prefs.dart';
import 'package:sprint1/core/network/api_service.dart';
import 'package:sprint1/core/network/dio_error_interceptor.dart';
import 'package:sprint1/core/network/hive_service.dart';
import 'package:sprint1/features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import 'package:sprint1/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:sprint1/features/auth/data/repository/auth_local_repository.dart';
import 'package:sprint1/features/auth/data/repository/auth_remote_repository.dart';
import 'package:sprint1/features/auth/domain/use_case/login_usecase.dart';
import 'package:sprint1/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:sprint1/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:sprint1/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sprint1/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:sprint1/features/home/data/repository/product_repository_impl.dart';
import 'package:sprint1/features/home/domain/repository/product_repository.dart';
import 'package:sprint1/features/home/domain/use_case/get_products.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  print('Initializing dependencies'); // Debug dependency setup
  // Ensure Flutter bindings are initialized for plugins like SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all asynchronous dependencies in the correct order
  await _initSharedPreferences();
  await _initHiveService();
  await _initApiServices();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  // Uncomment and implement if needed
  // await _initSplashScreenDependencies();
}

/// Initializes and registers SharedPreferences as a lazy singleton.
Future<void> _initSharedPreferences() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  print('SharedPreferences initialized');
}

/// Initializes and registers HiveService as a lazy singleton.
_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
  print('HiveService initialized');
}

/// Initializes and registers Dio and ApiService for all features.
_initApiServices() {
  print('Initializing ApiServices');
  // Register Dio as a lazy singleton for API calls
  getIt.registerLazySingleton<Dio>(
    () => Dio()
      ..options.baseUrl = ApiEndpoints.baseUrl // Use baseUrl from ApiEndpoints
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ))
      ..interceptors.add(
          DioErrorInterceptor()), // Assuming this is your custom interceptor
  );

  // Register a single ApiService instance for both auth and Home (using core/network/api_service.dart)
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<Dio>()),
  );
  print('ApiService initialized');
}

/// Initializes dependencies for the Home feature.
Future<void> _initHomeDependencies() async {
  print('Initializing Home dependencies');
  // Register ProductRepositoryImpl (data layer), using the core ApiService
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<ApiService>()),
  );

  // Register GetProducts (domain layer)
  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(getIt<ProductRepository>()),
  );

  // Register HomeBloc (presentation layer)
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt<GetProducts>()),
  );
  print('HomeBloc registered'); // Debug HomeBloc registration

  // Register HomeCubit (presentation layer, already exists but included for clarity)
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
  print('HomeCubit registered');
}

/// Initializes dependencies for the Register feature.
_initRegisterDependencies() {
  print('Initializing Register dependencies');
  // Register AuthLocalDataSource
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // Register AuthRemoteDataSource, using the core Dio
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // Register AuthLocalRepository
  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // Register AuthRemoteRepository
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // Register RegisterUseCase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // Register RegisterBloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );
  print('Register dependencies initialized');
}

/// Initializes dependencies for the Login feature.
Future<void> _initLoginDependencies() async {
  print('Initializing Login dependencies');
  // Register TokenSharedPrefs, which depends on SharedPreferences
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // Register LoginUseCase
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  // Register LoginBloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
  print('LoginBloc registered');

  // Register UploadImageUsecase
  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  print('Login dependencies initialized');
}

/// Initializes dependencies for the SplashScreen feature (uncomment and implement if needed).
// Future<void> _initSplashScreenDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<LoginBloc>()),
//   );
// }
