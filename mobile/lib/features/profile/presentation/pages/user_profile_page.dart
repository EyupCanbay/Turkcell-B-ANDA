import 'package:flutter/material.dart';
import '../styles/profile_colors.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_user_card.dart';
import '../widgets/profile_achievement_row.dart';
import '../widgets/profile_skill_card.dart';
import '../widgets/profile_badges_header.dart';
import '../widgets/profile_badges_grid.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileColors.backgroundLight,
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileAppBar(),
              ProfileUserCard(),
              SizedBox(height: 8),
              ProfileAchievementRow(),
              SizedBox(height: 12),
              ProfileSkillCard(),
              SizedBox(height: 12),
              ProfileBadgesHeader(),
              ProfileBadgesGrid(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
