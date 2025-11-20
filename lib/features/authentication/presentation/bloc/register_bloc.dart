import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterFullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });

    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SubmitRegister>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      // TODO: implement API call using repository
      await Future.delayed(const Duration(seconds: 1)); // simulating call

      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
