import '../../domain/entities/course_detail.dart';

class CourseDetailState {
  final bool isLoading;
  final CourseDetail? course;
  final String? error;

  CourseDetailState({
    this.isLoading = false,
    this.course,
    this.error,
  });

  CourseDetailState copyWith({
    bool? isLoading,
    CourseDetail? course,
    String? error,
  }) {
    return CourseDetailState(
      isLoading: isLoading ?? this.isLoading,
      course: course ?? this.course,
      error: error,
    );
  }
}
