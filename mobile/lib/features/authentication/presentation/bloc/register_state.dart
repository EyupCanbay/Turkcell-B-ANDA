import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  const RegisterState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        isLoading,
        isSuccess,
        errorMessage,
        successMessage
      ];
}
