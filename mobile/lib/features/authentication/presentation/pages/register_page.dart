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
        backgroundColor: const Color(0xFFE9ECF0),
        body: Stack(
          children: [
            // Yellow background with ellipse effect
            Positioned(
              top: -150,
              left: 0,
              right: 0,
              child: Container(
                height: 450,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD500),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(600, 200),
                    bottomRight: Radius.elliptical(600, 200),
                  ),
                ),
              ),
            ),

            // MAIN CONTENT
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // LOGO
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/images/turkcell_logo.png"),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Kaydol",
                              style: TextStyle(
                                color: Color(0xFF002B5C),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Yeni bir hesap oluştur",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // FORM FIELDS
                            AppTextField(
                              label: "İsim Soyisim",
                              controller: fullNameCtrl,
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 16),

                            AppTextField(
                              label: "Email",
                              controller: emailCtrl,
                              icon: Icons.mail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),

                            AppTextField(
                              label: "Şifre",
                              controller: passwordCtrl,
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                            const SizedBox(height: 24),

                            // BUTTON
                            BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF002B5C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<RegisterBloc>().add(
                                          RegisterFullNameChanged(
                                              fullNameCtrl.text));
                                      context.read<RegisterBloc>().add(
                                          RegisterEmailChanged(emailCtrl.text));
                                      context.read<RegisterBloc>().add(
                                          RegisterPasswordChanged(
                                              passwordCtrl.text));
                                      context
                                          .read<RegisterBloc>()
                                          .add(SubmitRegister());
                                    },
                                    child: state.isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "Kaydol",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // LOGIN REDIRECT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Hesabın var mı? ",
                            style: TextStyle(
                              color: Color(0xFF002B5C),
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, "/login"),
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(
                                color: Color(0xFF0077C8),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
