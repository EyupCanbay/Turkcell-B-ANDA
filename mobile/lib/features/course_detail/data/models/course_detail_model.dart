import '../../domain/entities/course_detail.dart';

class CourseDetailModel extends CourseDetail {
  CourseDetailModel({
    required super.id,
    required super.categoryId,
    required super.categoryName,
    required super.title,
    required super.videoUrl,
    required super.durationMin,
    required super.difficulty,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailModel(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      categoryName: json['category_name'] ?? "",
      title: json['title'] ?? "",
      videoUrl: json['video_url'] ?? "",
      durationMin: json['duration_min'] ?? 0,
      difficulty: json['difficulty'] ?? "",
    );
  }
}
