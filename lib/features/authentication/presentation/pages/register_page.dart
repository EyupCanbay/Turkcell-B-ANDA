import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import '../widgets/app_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Registration Success!")),
                );
              }
            },
            child: Column(
              children: [
                AppTextField(
                  label: "Full Name",
                  controller: fullNameCtrl,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: "Email",
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  label: "Password",
                  controller: passwordCtrl,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              context.read<RegisterBloc>().add(
                                    RegisterFullNameChanged(fullNameCtrl.text),
                                  );
                              context.read<RegisterBloc>().add(
                                    RegisterEmailChanged(emailCtrl.text),
                                  );
                              context.read<RegisterBloc>().add(
                                    RegisterPasswordChanged(passwordCtrl.text),
                                  );
                              context
                                  .read<RegisterBloc>()
                                  .add(SubmitRegister());
                            },
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Register"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
