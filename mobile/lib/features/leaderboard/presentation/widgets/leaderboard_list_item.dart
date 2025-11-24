import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leaderboard_user.dart';

class LeaderboardListItem extends StatelessWidget {
  final LeaderboardUser user;
  final int rank;

  const LeaderboardListItem({
    super.key,
    required this.user,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(12),
        // Hafif gölge
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Sıralama No
          SizedBox(
            width: 30,
            child: Text(
              "$rank",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textSub,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/turkcell_logo_rm.png'), // Placeholder
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // İsim
          Expanded(
            child: Text(
              user.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
          ),

          // Puan
          Text(
            "${user.score} pts",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSub,
            ),
          ),
        ],
      ),
    );
  }
}
