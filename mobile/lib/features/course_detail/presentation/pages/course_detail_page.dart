import 'package:flutter/material.dart';
import '../styles/cd_colors.dart';
import '../widgets/cd_header.dart';
import '../widgets/cd_top_card.dart';
import '../widgets/cd_video_player.dart';
import '../widgets/cd_lesson_info.dart';
import '../widgets/cd_description_card.dart';
import '../widgets/cd_quiz_card.dart';
import '../widgets/cd_last_performance.dart';
import '../widgets/cd_lessons_list.dart';
import 'quiz_page.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CdColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            const _CourseDetailBody(),
            const _CourseDetailBottomButton(),
          ],
        ),
      ),
    );
  }
}

class _CourseDetailBody extends StatelessWidget {
  const _CourseDetailBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CdHeader(title: "Course Details"),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const CdTopCard(),
                // CdVideoPlayer(videoUrl: "test" //TODO
                //     ),
                const CdLessonInfo(),
                const CdDescriptionCard(),
                CdQuizCard(
                  onStartQuiz: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QuizPage(),
                      ),
                    );
                  },
                ),
                const CdLastPerformance(),
                const CdLessonsList(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CourseDetailBottomButton extends StatelessWidget {
  const _CourseDetailBottomButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: CdColors.backgroundLight.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // Continue Learning Action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CdColors.gncYellow,
              foregroundColor: CdColors.gncBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Continue Learning",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
