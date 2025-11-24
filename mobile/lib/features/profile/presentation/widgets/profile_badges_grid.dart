import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileBadgesGrid extends StatelessWidget {
  const ProfileBadgesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      {
        "icon": Icons.lightbulb_outline,
        "label": "Yaratıcı",
        "color": Colors.orange
      },
      {
        "icon": Icons.group_work_outlined,
        "label": "Takım",
        "color": Colors.blue
      },
      {
        "icon": Icons.psychology_outlined,
        "label": "Çözücü",
        "color": Colors.purple
      },
      {
        "icon": Icons.menu_book_outlined,
        "label": "Öğrenci",
        "color": Colors.green
      },
      {
        "icon": Icons.emoji_events_outlined,
        "label": "Lider",
        "color": Colors.grey
      }, // Kilitli gibi
      {
        "icon": Icons.rocket_launch_outlined,
        "label": "İnovatif",
        "color": Colors.grey
      }, // Kilitli
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Rozetlerim",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Tümünü Gör",
                  style: TextStyle(
                      color: AppColors.designYellow,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: badges.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final badge = badges[index];
              final isLocked = (index > 3);

              return Opacity(
                opacity: isLocked ? 0.4 : 1.0,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.cardLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        badge["icon"] as IconData,
                        size: 32,
                        color: badge["color"] as Color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      badge["label"] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
