class LessonModel {
  final int id;
  final int categoryId;
  final String categoryName;
  final String title;
  final String? videoUrl;
  final int durationMin;
  final String difficulty;

  LessonModel({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.title,
    this.videoUrl,
    required this.durationMin,
    required this.difficulty,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      categoryId: json['category_id'] as int,
      categoryName: (json['category_name'] ?? "") as String,
      title: json['title'] as String,
      videoUrl: json['video_url'] as String?,
      durationMin: json['duration_min'] as int,
      difficulty: json['difficulty'] as String,
    );
  }
}
