import 'package:flutter/material.dart';
import '../styles/profile_colors.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: ProfileColors.cardLight,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            _buildAvatar(),
            const SizedBox(height: 16),
            _buildNameAndId(),
            const SizedBox(height: 16),
            _buildLocationAndSchool(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: NetworkImage("https://picsum.photos/200"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: -2,
          bottom: 0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: ProfileColors.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: ProfileColors.backgroundLight,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.photo_camera,
              size: 18,
              color: ProfileColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndId() {
    return Column(
      children: const [
        Text(
          "Cem Yılmaz",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: ProfileColors.textLight,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "GNC12345",
          style: TextStyle(
            fontSize: 15,
            color: ProfileColors.subtextLight,
          ),
        )
      ],
    );
  }

  Widget _buildLocationAndSchool() {
    return Column(
      children: const [
        _IconText(icon: Icons.location_on, text: "Istanbul"),
        SizedBox(height: 8),
        _IconText(icon: Icons.school, text: "Marmara University"),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: ProfileColors.subtextLight, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: ProfileColors.textLight,
          ),
        ),
      ],
    );
  }
}
