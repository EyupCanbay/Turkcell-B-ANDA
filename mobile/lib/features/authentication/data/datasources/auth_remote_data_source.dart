import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> register({
    required String name,
    required String email,
    required String password,
  });

  Future<String> login({
    required String email,
    required String password,
  });

  Future<UserModel> getProfile();

  Future<String> completeProfile({
    required String city,
    required String university,
    required String skillLevel,
  });

  Future<String> deleteAccount();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthRemoteDataSourceImpl({
    required this.dio,
    required this.storage,
  });

  // ---------------------------------------------------------------------------
  // REGISTER
  // ---------------------------------------------------------------------------
  @override
  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    print("AuthRemoteDataSource.register ÇAĞRILDI: $name, $email");

    final response = await dio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      return response.data.toString();
    }

    throw Exception("Beklenmeyen yanıt: ${response.statusCode}");
  }

  // ---------------------------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------------------------
  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        /// Swagger dönüşü:
        /// { "token": "JWT_TOKEN" }
        if (!data.containsKey("token")) {
          throw Exception("Token bulunamadı!");
        }

        final token = data["token"] as String;
        await storage.write(key: 'token', value: token);

        return token;
      }

      throw Exception("Giriş başarısız: ${response.statusCode}");
    } on DioException catch (e) {
      throw Exception(e.response?.data?.toString() ?? "Giriş başarısız.");
    }
  }

  // ---------------------------------------------------------------------------
  // GET PROFILE
  // ---------------------------------------------------------------------------
  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await dio.get('/api/secure/me');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception("Profil alınamadı.");
    } on DioException catch (e) {
      throw Exception(e.response?.data?.toString() ?? "Profil alınamadı.");
    }
  }

  // ---------------------------------------------------------------------------
  // COMPLETE PROFILE
  // ---------------------------------------------------------------------------
  @override
  Future<String> completeProfile({
    required String city,
    required String university,
    required String skillLevel,
  }) async {
    try {
      final response = await dio.put(
        '/api/complete-profile',
        data: {
          'city': city,
          'university': university,
          'skill_level': skillLevel,
        },
      );

      if (response.statusCode == 200) {
        return response.data.toString();
      }

      throw Exception("Profil tamamlanamadı.");
    } on DioException catch (e) {
      throw Exception(e.response?.data?.toString() ?? "Profil tamamlanamadı.");
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE ACCOUNT
  // ---------------------------------------------------------------------------
  @override
  Future<String> deleteAccount() async {
    try {
      final response = await dio.delete('/api/secure/me');

      if (response.statusCode == 200) {
        return response.data.toString();
      }

      throw Exception("Hesap silinemedi.");
    } on DioException catch (e) {
      throw Exception(e.response?.data?.toString() ?? "Hesap silinemedi.");
    }
  }
}
