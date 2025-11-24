import 'package:bi_anda/features/home/presentation/pages/home_page.dart';
import 'package:bi_anda/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:bi_anda/features/my_courses/presentation/pages/my_courses_page.dart';
import 'package:flutter/material.dart';
import 'features/profile/presentation/pages/user_profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(), // Home
    MyCoursesPage(), // Lessons
    LeaderboardPage(), //LeaderBoard
    UserProfilePage(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[700],
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: "Lessons",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_outlined),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
