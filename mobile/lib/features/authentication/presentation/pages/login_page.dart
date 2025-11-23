import 'package:bi_anda/core/common/widgets/app_snackbar.dart';
import 'package:bi_anda/core/theme/app_colors.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/login_bloc.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/login_event.dart';
import 'package:bi_anda/features/authentication/presentation/bloc/login_state.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_button.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_text_field.dart';
import 'package:bi_anda/features/authentication/presentation/widgets/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(getIt()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9ECF0),
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            }

            if (state.errorMessage != null) {
              AppSnackBar.showError(context, state.errorMessage!);
            }
          },
          builder: (context, state) {
            final bloc = context.read<LoginBloc>();

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
                      height: 110,
                      width: 110,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.turkcellYellow,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 8,
                          )
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
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "Giriş Yap",
                                  style: AppTextStyles.titleLarge
                                      .copyWith(color: AppColors.darkNavy),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Hesabına erişmek için giriş yap",
                                  style: AppTextStyles.bodyMedium
                                      .copyWith(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            "Email",
                            style: AppTextStyles.label,
                          ),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "email@adresin.com",
                            prefixIcon: Icons.mail,
                            onChanged: (v) => context
                                .read<LoginBloc>()
                                .add(LoginEmailChanged(email: v)),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Şifre",
                            style: AppTextStyles.label,
                          ),
                          const SizedBox(height: 6),
                          AppTextField(
                            hint: "••••••••",
                            isPassword: true,
                            prefixIcon: Icons.lock,
                            onChanged: (v) => context
                                .read<LoginBloc>()
                                .add(LoginPasswordChanged(password: v)),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Şifremi Unuttum",
                              style: AppTextStyles.bodyMedium
                                  .copyWith(color: AppColors.darkNavy),
                            ),
                          ),
                          const SizedBox(height: 24),
                          AppButton(
                            text: "Giriş Yap",
                            isLoading: state.isLoading,
                            onPressed: () => bloc.add(SubmitLogin()),
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
                          "Hesabın yok mu? ",
                          style: AppTextStyles.bodyMedium
                              .copyWith(color: AppColors.darkNavy),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, "/register"),
                          child: Text(
                            "Kayıt Ol",
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
