import 'package:bi_anda/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:bi_anda/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:bi_anda/features/authentication/domain/repositories/auth_repository.dart';
import 'package:bi_anda/features/authentication/domain/usecases/complete_profile_usecase.dart';
import 'package:bi_anda/features/authentication/domain/usecases/delete_account_usecase.dart';
import 'package:bi_anda/features/authentication/domain/usecases/get_profile.dart';
import 'package:bi_anda/features/authentication/domain/usecases/login_usecase.dart';
import 'package:bi_anda/features/authentication/domain/usecases/register_usecase.dart';
import 'package:bi_anda/features/course_detail/data/datasources/course_detail_remote_data_source.dart';
import 'package:bi_anda/features/course_detail/data/repository/course_detail_repository_impl.dart';
import 'package:bi_anda/features/course_detail/domain/repository/course_detail_repository.dart';
import 'package:bi_anda/features/course_detail/domain/usecases/get_course_detail_usecase.dart';
import 'package:bi_anda/features/home/data/datasources/home_remote_data_source.dart';
import 'package:bi_anda/features/home/data/repository/home_repository_impl.dart';
import 'package:bi_anda/features/home/domain/repository/home_repository.dart';
import 'package:bi_anda/features/home/domain/usecases/get_categories.dart';
import 'package:bi_anda/features/home/domain/usecases/get_lessons.dart';
import 'package:bi_anda/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

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
        baseUrl:
            'http://10.34.20.43:8080', //172.20.10.5 telefon //10.34.20.43 sanal emülatör
        headers: {
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // LOG INTERCEPTOR
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );

    // TOKEN INTERCEPTOR
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

  // Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dio: getIt<Dio>(),
      storage: getIt<FlutterSecureStorage>(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
    ),
  );

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

  // Home
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<HomeRepository>()),
  );

  getIt.registerLazySingleton<GetLessonsUseCase>(
    () => GetLessonsUseCase(getIt<HomeRepository>()),
  );

  //course detail

  // DataSource
  getIt.registerLazySingleton<CourseDetailRemoteDataSource>(
    () => CourseDetailRemoteDataSourceImpl(getIt<Dio>()),
  );

// Repository
  getIt.registerLazySingleton<CourseDetailRepository>(
    () => CourseDetailRepositoryImpl(getIt<CourseDetailRemoteDataSource>()),
  );

// UseCase
  getIt.registerLazySingleton<GetCourseDetailUseCase>(
    () => GetCourseDetailUseCase(getIt<CourseDetailRepository>()),
  );

  //Profile
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: getIt<GetProfileUseCase>(),
      completeProfileUseCase: getIt<CompleteProfileUseCase>(),
    ),
  );
}
