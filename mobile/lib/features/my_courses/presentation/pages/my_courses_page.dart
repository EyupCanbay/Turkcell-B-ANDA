import 'package:flutter/material.dart';
import '../styles/mycourses_colors.dart';
import '../widgets/mycourses_app_bar.dart';
import '../widgets/mycourses_category_filters.dart';
import '../widgets/mycourses_course_card.dart';
import '../widgets/mycourses_fab.dart';

class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyCoursesColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  MyCoursesAppBar(),
                  SizedBox(height: 4),
                  MyCoursesCategoryFilters(),
                  SizedBox(height: 4),
                  MyCoursesCourseList(),
                ],
              ),
            ),
            const Positioned(
              right: 16,
              bottom: 16,
              child: MyCoursesFAB(),
            ),
          ],
        ),
      ),
    );
  }
}
