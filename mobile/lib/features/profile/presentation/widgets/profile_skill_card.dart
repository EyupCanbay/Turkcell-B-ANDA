import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileSkillCard extends StatelessWidget {
  final String skillLevel;

  const ProfileSkillCard({super.key, required this.skillLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                "Yetenek Seviyesi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              Text(
                skillLevel.isEmpty ? "Belirsiz" : skillLevel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.designYellow,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.6,
              minHeight: 10,
              backgroundColor: AppColors.borderLight,
              color: AppColors.designYellow,
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "İleri seviyeye %40 kaldı",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSub,
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
