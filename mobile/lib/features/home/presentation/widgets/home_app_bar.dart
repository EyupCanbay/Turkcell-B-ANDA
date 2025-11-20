import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = HomePage.primaryColor;
    const turkcellYellow = HomePage.turkcellYellow;

    return Container(
      color: turkcellYellow,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.menu, size: 28, color: primaryColor),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Welcome Back!",
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none,
                color: primaryColor, size: 28),
          ),
        ],
      ),
    );
  }
}
