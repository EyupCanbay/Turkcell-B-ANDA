import 'package:bi_anda/core/common/widgets/app_snackbar.dart';
import 'package:bi_anda/core/theme/app_colors.dart';
import 'package:bi_anda/features/authentication/domain/usecases/register_usecase.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/register_bloc.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/register_event.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/register_state.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_button.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_text_field.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(getIt<RegisterUseCase>()),
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
            if (state.errorMessage != null) {
              AppSnackBar.showError(context, state.errorMessage!);
            }

            if (state.isSuccess) {
              AppSnackBar.showSuccess(
                  context, state.successMessage ?? "Kayıt başarılı!");

              Future.delayed(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              });
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
                      child: Image.asset(
                        "assets/images/turkcell_logo_rm.png",
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
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: AppColors.darkNavy,
                                  ),
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

                          // FULL NAME
                          Text("İsim Soyisim", style: AppTextStyles.label),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "Adını ve soyadını yaz",
                            prefixIcon: Icons.person,
                            onChanged: (v) =>
                                bloc.add(RegisterNameChanged(name: v)),
                          ),

                          // EMAIL
                          const SizedBox(height: 16),
                          Text("Email", style: AppTextStyles.label),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "email@adresin.com",
                            prefixIcon: Icons.mail,
                            onChanged: (v) =>
                                bloc.add(RegisterEmailChanged(email: v)),
                          ),

                          // PASSWORD
                          const SizedBox(height: 16),
                          Text("Şifre", style: AppTextStyles.label),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "••••••••",
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            onChanged: (v) =>
                                bloc.add(RegisterPasswordChanged(password: v)),
                          ),

                          // BUTTON
                          const SizedBox(height: 24),
                          AppButton(
                            text: "Kaydol",
                            isLoading: state.isLoading,
                            onPressed: () {
                              bloc.add(const SubmitRegister());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom navigation text
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hesabın var mı? ",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkNavy,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                            );
                          },
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
