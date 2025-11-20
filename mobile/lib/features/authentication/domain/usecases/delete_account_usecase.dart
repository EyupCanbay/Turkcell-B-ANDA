import '../repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<String> call() {
    return repository.deleteAccount();
  }
}
