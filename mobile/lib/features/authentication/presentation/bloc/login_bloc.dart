import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';
import 'package:bi_anda/features/authentication/domain/usecases/login_usecase.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(const LoginState()) {
    // 🔹 Email değişimi
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });

    // 🔹 Şifre değişimi  ✅ BURASI YOKSA O HATAYI ALIRSIN
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });

    // 🔹 Login butonu
    on<SubmitLogin>((event, emit) async {
      if (state.email.trim().isEmpty || state.password.trim().isEmpty) {
        emit(state.copyWith(
          errorMessage: "Email ve şifre zorunlu",
          isLoading: false,
        ));
        return;
      }

      emit(state.copyWith(
          isLoading: true, errorMessage: null, isSuccess: false));

      try {
        final token = await loginUseCase(
          state.email.trim(),
          state.password.trim(),
        );

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          token: token,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ));
      }
    });
  }
}
