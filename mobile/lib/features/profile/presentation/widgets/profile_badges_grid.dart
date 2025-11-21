import 'package:flutter/material.dart';
import '../styles/profile_colors.dart';

class ProfileBadgesGrid extends StatelessWidget {
  const ProfileBadgesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.9,
        children: const [
          _BadgeItem(label: "Creative", imageUrl: "https://picsum.photos/220"),
          _BadgeItem(
              label: "Team Player", imageUrl: "https://picsum.photos/221"),
          _BadgeItem(label: "Solver", imageUrl: "https://picsum.photos/222"),
          _BadgeItem(label: "Learner", imageUrl: "https://picsum.photos/223"),
          Opacity(
            opacity: 0.4,
            child: _BadgeItem(
                label: "Leader", imageUrl: "https://picsum.photos/224"),
          ),
          Opacity(
            opacity: 0.4,
            child: _BadgeItem(
                label: "Innovator", imageUrl: "https://picsum.photos/225"),
          ),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final String label;
  final String imageUrl;

  const _BadgeItem({
    required this.label,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: ProfileColors.cardLight,
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ProfileColors.textLight,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
