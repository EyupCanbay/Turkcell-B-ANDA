import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterState({
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [fullName, email, password, isLoading, isSuccess, errorMessage];
}
