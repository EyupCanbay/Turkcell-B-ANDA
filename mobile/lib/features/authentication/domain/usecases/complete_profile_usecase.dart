import '../repositories/auth_repository.dart';

class CompleteProfileUseCase {
  final AuthRepository repository;

  CompleteProfileUseCase(this.repository);

  Future<String> call(String city, String university, String skillLevel) {
    return repository.completeProfile(city, university, skillLevel);
  }
}
