import 'package:bi_anda/features/authentication/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/profile_user_card.dart';
import '../widgets/profile_achievement_row.dart';
import '../widgets/profile_skill_card.dart';
import '../widgets/profile_badges_grid.dart';
import '../widgets/complete_profile_popup.dart'; // Popup'ı import et

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Service locator'dan güncel bloc'u alıyoruz
      create: (context) => getIt<ProfileBloc>()..add(LoadProfileEvent()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              // Profil yüklendiğinde eksik bilgi var mı kontrol et
              if (state is ProfileLoaded) {
                final user = state.user;
                // Eğer şehir veya üniversite boşsa kullanıcıyı darlayabiliriz :)
                // İstersen burayı açabilirsin, sayfa açılır açılmaz popup çıkar:
                /*
                if (user.city == null || user.city!.isEmpty || user.university == null) {
                   _showEditPopup(context, user);
                }
                */
              }
            },
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.turkcellYellow));
              }

              User? currentUser;
              if (state is ProfileLoaded) {
                currentUser = state.user;
              }

              // ProfilApp Bar'ı buraya taşıdım çünkü context'e ihtiyacımız var (Bloc için)
              return Column(
                children: [
                  _buildAppBar(
                      context, currentUser), // Context ve User'ı gönderiyoruz

                  if (state is ProfileError)
                    Expanded(
                        child: Center(child: Text("Hata: ${state.message}")))
                  else if (currentUser != null)
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ProfileUserCard(user: currentUser),
                            const ProfileAchievementRow(),
                            ProfileSkillCard(
                                skillLevel:
                                    currentUser.skillLevel ?? "Belirsiz"),
                            const ProfileBadgesGrid(),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // App Bar'ı metot olarak buraya aldık ki Bloc'a erişebilelim
  Widget _buildAppBar(BuildContext context, User? user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          const Text(
            "Profil",
            style: TextStyle(
              color: AppColors.textMain,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.edit, color: AppColors.textMain),
              onPressed: () {
                if (user != null) {
                  _showEditPopup(context, user);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Popup'ı açan fonksiyon
  void _showEditPopup(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        // BlocProvider.value kullanarak mevcut Bloc'u dialog içine taşıyoruz
        return BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: CompleteProfilePopup(
            currentCity: user.city,
            currentUniversity: user.university,
            currentSkill: user.skillLevel,
          ),
        );
      },
    );
  }
}
