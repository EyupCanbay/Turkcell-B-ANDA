import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../authentication/domain/entities/user.dart';

class ProfileUserCard extends StatelessWidget {
  final User user;

  const ProfileUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.softShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profil Resmi
          Stack(
            children: [
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/turkcell_logo_rm.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 4),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.designYellow,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.backgroundLight, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt,
                      size: 18, color: AppColors.textMain),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // İsim
          Text(
            user.name ?? "İsimsiz Kullanıcı",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          // ID (Email veya ID kullanılabilir)
          Text(
            "Seviye:${user.skillLevel}",
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSub,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          const SizedBox(height: 24),

          // Bilgiler
          Column(
            children: [
              _buildInfoRow(
                  Icons.location_on_outlined, user.city ?? "Konum ekle"),
              const SizedBox(height: 12),
              _buildInfoRow(
                  Icons.school_outlined, user.university ?? "Üniversite ekle"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24, color: AppColors.textSub),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textMain,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
      ],
    );
  }
}
