import 'package:flutter/material.dart';
import '../styles/profile_colors.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ProfileColors.borderLight),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: ProfileColors.textLight),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: ProfileColors.textLight,
                ),
              ),
            ),
          ),
          const Icon(Icons.edit, color: ProfileColors.textLight, size: 24),
        ],
      ),
    );
  }
}
