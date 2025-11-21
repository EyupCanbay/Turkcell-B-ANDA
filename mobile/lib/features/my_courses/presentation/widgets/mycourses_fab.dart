import 'package:flutter/material.dart';
import '../styles/mycourses_colors.dart';

class MyCoursesFAB extends StatelessWidget {
  const MyCoursesFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: MyCoursesColors.primary,
          foregroundColor: MyCoursesColors.gncBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        icon: const Icon(Icons.play_arrow_rounded, size: 30),
        label: const Text(
          "Derse Devam Et",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
