import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository repository;

  GetProfileUseCase(this.repository);

  Future<User> call() {
    return repository.getProfile();
  }
}
