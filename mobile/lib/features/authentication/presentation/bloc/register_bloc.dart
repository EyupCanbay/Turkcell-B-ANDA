import 'package:bi_anda/features/authentication/domain/usecases/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(const RegisterState()) {
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SubmitRegister>((event, emit) async {
      // Basit validation
      if (state.name.trim().isEmpty ||
          state.email.trim().isEmpty ||
          state.password.trim().isEmpty) {
        emit(state.copyWith(
          errorMessage: "Tüm alanlar zorunludur.",
          isLoading: false,
          isSuccess: false,
        ));
        return;
      }

      emit(state.copyWith(
        isLoading: true,
        errorMessage: null,
        isSuccess: false,
      ));

      try {
        // 🔥 BURADA GERÇEK API ÇAĞRISI YAPILIYOR
        final message = await registerUseCase(
          state.name.trim(),
          state.email.trim(),
          state.password.trim(),
        );

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          successMessage: message,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: e.toString().replaceAll("Exception: ", ""),
        ));
      }
    });
  }
}
