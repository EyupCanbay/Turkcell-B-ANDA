import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leaderboard_user.dart';

class TopThreePodium extends StatelessWidget {
  final List<LeaderboardUser> users;

  const TopThreePodium({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) return const SizedBox.shrink();

    // Güvenlik kontrolü: en az 3 kullanıcı yoksa olanları gösterir
    final first = users.isNotEmpty ? users[0] : null;
    final second = users.length > 1 ? users[1] : null;
    final third = users.length > 2 ? users[2] : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.end, // Alt hizalama (Podium etkisi)
        children: [
          // 2. SIRA (SOL)
          if (second != null)
            _buildPodiumItem(second, 2, 80, Colors.grey.shade300),

          const SizedBox(width: 16),

          // 1. SIRA (ORTA - BÜYÜK)
          if (first != null)
            _buildPodiumItem(first, 1, 100, AppColors.designYellow,
                isWinner: true),

          const SizedBox(width: 16),

          // 3. SIRA (SAĞ)
          if (third != null)
            _buildPodiumItem(third, 3, 80, Colors.orange.shade300),
        ],
      ),
    );
  }

  Widget _buildPodiumItem(
      LeaderboardUser user, int rank, double size, Color borderColor,
      {bool isWinner = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar Çerçevesi
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 4),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/turkcell_logo_rm.png'), // Placeholder
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Sıralama Rozeti
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: isWinner ? 36 : 28,
                  height: isWinner ? 36 : 28,
                  decoration: BoxDecoration(
                    color: borderColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Center(
                    child: isWinner
                        ? const Icon(Icons.workspace_premium,
                            color: AppColors.primary, size: 20)
                        : Text(
                            "$rank",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isWinner ? 16 : 14,
            color: AppColors.textMain,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "${user.score} pts",
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSub,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
