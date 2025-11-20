import 'package:bi_anda/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:bi_anda/features/authentication/domain/usecases/complete_profile_usecase.dart';
import 'package:bi_anda/features/authentication/domain/usecases/delete_account_usecase.dart';
import 'package:bi_anda/features/authentication/domain/usecases/get_profile.dart';
import 'package:bi_anda/features/authentication/domain/usecases/login_usecase.dart';
import 'package:bi_anda/features/authentication/domain/usecases/register_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Secure Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Dio Client
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8080',
        headers: {
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // ---- LOG INTERCEPTOR (İstekleri – yanıtları görebileceğiz) ----
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    // ---- TOKEN INTERCEPTOR ----
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = getIt<FlutterSecureStorage>();
          final token = await storage.read(key: 'token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
      ),
    );

    return dio;
  });

  // Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(() {
    return AuthRemoteDataSourceImpl(
      dio: getIt<Dio>(),
      storage: getIt<FlutterSecureStorage>(),
    );
  });

  // Repository
  getIt.registerLazySingleton<AuthRepository>(() {
    return AuthRepositoryImpl(getIt<AuthRemoteDataSource>());
  });

  // Use Cases
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<CompleteProfileUseCase>(
    () => CompleteProfileUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(getIt<AuthRepository>()),
  );
}
