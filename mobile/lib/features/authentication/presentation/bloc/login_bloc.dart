import 'package:bi_anda/features/authentication/domain/usecases/login_usecase.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/login_event.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(const LoginState()) {
    /// Email değişti
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    /// Şifre değişti
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    /// Login butonuna tıklandı
    on<SubmitLogin>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        final token =
            await loginUseCase(state.email.trim(), state.password.trim());

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          token: token,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Giriş başarısız: ${e.toString()}",
        ));
      }
    });
  }
}
