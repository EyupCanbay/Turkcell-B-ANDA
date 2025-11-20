import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;

  final bool isLoading;
  final bool isSuccess;
  final String? token;
  final String? errorMessage;

  const LoginState({
    this.email = "",
    this.password = "",
    this.isLoading = false,
    this.isSuccess = false,
    this.token,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? token,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      token: token ?? this.token,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, isLoading, isSuccess, token, errorMessage];
}
