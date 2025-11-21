import 'package:flutter/material.dart';
import '../styles/mycourses_colors.dart';

class MyCoursesAppBar extends StatelessWidget {
  const MyCoursesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: MyCoursesColors.gncBlue),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Eğitimlerim",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: MyCoursesColors.gncBlue,
                ),
              ),
            ),
          ),
          const Icon(Icons.search, color: MyCoursesColors.gncBlue, size: 26),
        ],
      ),
    );
  }
}
