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

  @override
  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    print(name + email + password);
    // Swagger: 201 + string body ("Kayıt başarılı" vs.)
    return response.data.toString();
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    // Swagger: 200, body: object<string,string>
    // Backend ile "token" key ismi üzerinde anlaşmak en temizi
    final data = response.data as Map<String, dynamic>;
    final token = data['token'] as String? ??
        data['access_token'] as String? ??
        data.values.first as String; // fallback

    await storage.write(key: 'token', value: token);

    return token;
  }

  @override
  Future<UserModel> getProfile() async {
    final response = await dio.get('/api/secure/me');
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<String> completeProfile({
    required String city,
    required String university,
    required String skillLevel,
  }) async {
    final response = await dio.put(
      '/api/complete-profile',
      data: {
        'city': city,
        'university': university,
        'skill_level': skillLevel,
      },
    );

    return response.data.toString();
  }

  @override
  Future<String> deleteAccount() async {
    final response = await dio.delete('/api/secure/me');
    return response.data.toString();
  }
}
