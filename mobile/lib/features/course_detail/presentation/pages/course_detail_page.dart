import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/course_detail_bloc.dart';
import '../bloc/course_detail_event.dart';
import '../bloc/course_detail_state.dart';

import '../widgets/course_progress_header.dart';
import '../widgets/course_video_player.dart';
import '../widgets/course_description_card.dart';
import '../widgets/course_lesson_item.dart';

class CourseDetailPage extends StatelessWidget {
  final int courseId;

  const CourseDetailPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Sayfa açılır açılmaz API isteği gönderelim
    context.read<CourseDetailBloc>().add(LoadCourseDetail(courseId));

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F5),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          /// LOADING
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ERROR
          if (state.error != null) {
            return Center(
              child: Text(
                "Hata: ${state.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          /// COURSE NULL → backend veri dönmemişse
          if (state.course == null) {
            return const Center(
              child: Text("Kurs bulunamadı"),
            );
          }

          final course = state.course!;

          return Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CourseProgressHeader(progress: 0.66),

                      const SizedBox(height: 8),

                      /// Video Player
                      CourseVideoPlayer(videoUrl: course.videoUrl),

                      const SizedBox(height: 16),

                      _buildMeta(course),

                      const SizedBox(height: 16),

                      CourseDescriptionCard(
                        description:
                            "Bu kurs '${course.title}' hakkında detaylı eğitim sunar.",
                      ),

                      const SizedBox(height: 16),

                      _buildLessons(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 12),
      color: Colors.white.withOpacity(0.9),
      child: Row(
        children: [
          _appBarRoundButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Course Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff002B5C),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _appBarRoundButton({
    required IconData icon,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Icon(icon, color: Color(0xff002B5C)),
      ),
    );
  }

  Widget _buildMeta(course) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.title,
            style: const TextStyle(
              color: Color(0xff002B5C),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.schedule, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Text("${course.durationMin} min"),
              const SizedBox(width: 16),
              const Icon(Icons.signal_cellular_alt,
                  size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Text(course.difficulty),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLessons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            "Course Lessons",
            style: TextStyle(
              color: Color(0xff002B5C),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          /// Şimdilik sahte 3 ders gösteriyoruz
          CourseLessonItem(
            title: "1. Introduction",
            isCurrent: true,
            isCompleted: false,
          ),
          CourseLessonItem(
            title: "2. Deep Concepts",
            isCompleted: true,
            isCurrent: false,
          ),
          CourseLessonItem(
            title: "3. Best Practices",
            isCompleted: false,
            isCurrent: false,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white.withOpacity(0.9),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffFFCA00),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
        child: const Text(
          "Continue Learning",
          style: TextStyle(
            color: Color(0xff002B5C),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
