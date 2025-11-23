import 'package:bi_anda/core/di/service_locator.dart';
import 'package:bi_anda/features/course_detail/domain/usecases/get_course_detail_usecase.dart';
import 'package:bi_anda/features/course_detail/presentation/bloc/course_detail_bloc.dart';
import 'package:bi_anda/features/course_detail/presentation/bloc/course_detail_event.dart';
import 'package:flutter/material.dart';
import 'package:bi_anda/features/home/data/models/lesson_model.dart';
import 'package:bi_anda/features/course_detail/presentation/pages/course_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCard extends StatelessWidget {
  final LessonModel lesson;

  const CourseCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => CourseDetailBloc(getIt<GetCourseDetailUseCase>())
                ..add(LoadCourseDetail(lesson.id)),
              child: CourseDetailPage(courseId: lesson.id),
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail (backend'de yoksa placeholder)
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage(
                    lesson.videoUrl ??
                        "https://via.placeholder.com/300x200?text=Thumbnail",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF002B5C),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.categoryName ?? "",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
