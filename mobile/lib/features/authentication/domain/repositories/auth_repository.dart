import '../entities/user.dart';

abstract class AuthRepository {
  Future<String> register(String name, String email, String password);
  Future<String> login(String email, String password); // token
  Future<User> getProfile();
  Future<String> completeProfile(
      String city, String university, String skillLevel);
  Future<String> deleteAccount();
}
