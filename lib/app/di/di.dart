import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint1/app/constants/api_endpoints.dart';
import 'package:sprint1/app/shared_prefs/token_shared_prefs.dart';
import 'package:sprint1/core/network/api_service.dart';
import 'package:sprint1/core/network/connectivity_service.dart';
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
import 'package:sprint1/features/home/data/data_source/product_local_data_source.dart';
import 'package:sprint1/features/home/data/data_source/product_remote_data_source.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/features/home/data/repository/product_repository_impl.dart';
import 'package:sprint1/features/home/domain/repository/product_repository.dart';
import 'package:sprint1/features/home/domain/use_case/get_products.dart';
import 'package:sprint1/features/home/presentation/bloc/home_bloc.dart';
import 'package:sprint1/features/home/presentation/view_model/home_cubit.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  print('Initializing dependencies');
  WidgetsFlutterBinding.ensureInitialized();

  await _initSharedPreferences();
  await _initHiveService();
  await _initApiServices();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  print('SharedPreferences initialized');
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
  print('HiveService initialized');
}

_initApiServices() {
  print('Initializing ApiServices');
  getIt.registerLazySingleton<Dio>(
    () => Dio()
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ))
      ..interceptors.add(DioErrorInterceptor()),
  );

  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(),
  );
  print('ApiService and ConnectivityService initialized');
}

Future<void> _initHomeDependencies() async {
  print('Initializing Home dependencies');
  // Register data sources
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(Hive.box<Product>('productsBox')),
  );

  // Register ProductRepositoryImpl (data layer)
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      getIt<ProductRemoteDataSource>(),
      getIt<ProductLocalDataSource>(),
      getIt<ConnectivityService>(),
    ),
  );

  // Register GetProducts (domain layer)
  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(getIt<ProductRepository>()),
  );

  // Register HomeBloc (presentation layer)
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt<GetProducts>()),
  );
  print('HomeBloc registered');

  // Register HomeCubit (presentation layer)
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
  print('HomeCubit registered');
}

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