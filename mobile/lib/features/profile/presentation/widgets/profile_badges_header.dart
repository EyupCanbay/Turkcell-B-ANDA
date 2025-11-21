import 'package:flutter/material.dart';
import '../styles/profile_colors.dart';

class ProfileBadgesHeader extends StatelessWidget {
  const ProfileBadgesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "My Badges",
            style: TextStyle(
              color: ProfileColors.textLight,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          Text(
            "View All",
            style: TextStyle(
              color: ProfileColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
