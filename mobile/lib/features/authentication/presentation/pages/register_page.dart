import 'package:bi_anda/core/common/widgets/app_snackbar.dart';
import 'package:bi_anda/core/di/theme/app_colors.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/register_bloc.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/register_event.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/register_state.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_button.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_text_field.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9ECF0),
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isSuccess) {
              AppSnackBar.showSuccess(context, "Kayıt başarılı!");
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              });
            }

            if (state.errorMessage != null) {
              AppSnackBar.showError(context, state.errorMessage!);
            }
          },
          builder: (context, state) {
            final bloc = context.read<RegisterBloc>();

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.turkcellYellow,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(500, 180),
                        bottomRight: Radius.elliptical(500, 180),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: Image.network(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuBZ1GvO-NeEiYlCIaEoHEDQ4xaomNCu9C2FgbSsLbGVvaaYUEWDBJSNswmPkG9S9LQBWBaZeVKF7lZGcG-Wn1AxzhRXjIUkUIi9tSoKn_uxMfaFfoNrpR0GDWzSxdko-fRWYtUFMEZ_AHojK-NWF7_V0IMDvKFLedF0dBwly6hJ_OuoyrjMzBTMwedUs2i81u3bEnY-hmzunUTQIqBOR4Y1nP0Uf0BhQRAFyDeKF-VmpFO2IgCsvNXA0yR5AaYcQummmNXNSnaJHM4",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "Kaydol",
                                  style: AppTextStyles.titleLarge
                                      .copyWith(color: AppColors.darkNavy),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Yeni bir hesap oluştur",
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text("İsim Soyisim", style: AppTextStyles.label),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "Adını ve soyadını yaz",
                            prefixIcon: Icons.person,
                            onChanged: (v) =>
                                bloc.add(RegisterFullNameChanged(v)),
                          ),
                          const SizedBox(height: 16),
                          Text("Email", style: AppTextStyles.label),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "email@adresin.com",
                            prefixIcon: Icons.mail,
                            onChanged: (v) => bloc.add(RegisterEmailChanged(v)),
                          ),
                          const SizedBox(height: 16),
                          Text("Şifre", style: AppTextStyles.label),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "••••••••",
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            onChanged: (v) =>
                                bloc.add(RegisterPasswordChanged(v)),
                          ),
                          const SizedBox(height: 24),
                          AppButton(
                            text: "Kaydol",
                            isLoading: state.isLoading,
                            onPressed: () {
                              bloc.add(SubmitRegister());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hesabın var mı? ",
                          style: AppTextStyles.bodyMedium
                              .copyWith(color: AppColors.darkNavy),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                          ),
                          child: Text(
                            "Giriş Yap",
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.turkcellBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
