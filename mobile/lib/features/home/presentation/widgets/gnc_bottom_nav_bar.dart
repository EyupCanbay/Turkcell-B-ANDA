import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class GnCBottomNavBar extends StatelessWidget {
  const GnCBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = HomePage.primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border(top: BorderSide(color: primaryColor.withOpacity(0.2))),
      ),
      child: Row(
        children: const [
          _NavItem(icon: Icons.home, label: "Home", selected: true),
          _NavItem(icon: Icons.quiz_outlined, label: "Quizzes"),
          _NavItem(icon: Icons.emoji_events_outlined, label: "Rewards"),
          _NavItem(icon: Icons.account_circle_outlined, label: "Profile"),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _NavItem({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = HomePage.primaryColor;

    final color = selected ? primaryColor : primaryColor.withOpacity(0.6);

    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
