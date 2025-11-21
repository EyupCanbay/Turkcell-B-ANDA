import 'package:flutter/material.dart';
import '../styles/profile_colors.dart';

class ProfileSkillCard extends StatelessWidget {
  const ProfileSkillCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ProfileColors.cardLight,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildProgressBar(),
            const SizedBox(height: 8),
            _buildToNextLevel(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Skill Level",
          style: TextStyle(
            color: ProfileColors.textLight,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        Text(
          "Intermediate",
          style: TextStyle(
            color: ProfileColors.primary,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: const LinearProgressIndicator(
        value: 0.6,
        minHeight: 10,
        backgroundColor: ProfileColors.borderLight,
        valueColor: AlwaysStoppedAnimation<Color>(ProfileColors.primary),
      ),
    );
  }

  Widget _buildToNextLevel() {
    return const Center(
      child: Text(
        "40% to Advanced",
        style: TextStyle(
          color: ProfileColors.subtextLight,
          fontSize: 13,
        ),
      ),
    );
  }
}
