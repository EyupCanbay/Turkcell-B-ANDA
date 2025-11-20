import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<String> register(String name, String email, String password) {
    return remote.register(name: name, email: email, password: password);
  }

  @override
  Future<String> login(String email, String password) {
    return remote.login(email: email, password: password);
  }

  @override
  Future<User> getProfile() {
    return remote.getProfile();
  }

  @override
  Future<String> completeProfile(
      String city, String university, String skillLevel) {
    return remote.completeProfile(
      city: city,
      university: university,
      skillLevel: skillLevel,
    );
  }

  @override
  Future<String> deleteAccount() {
    return remote.deleteAccount();
  }
}
