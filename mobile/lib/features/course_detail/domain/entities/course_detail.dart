class CourseDetail {
  final int id;
  final int categoryId;
  final String categoryName;
  final String title;
  final String videoUrl;
  final int durationMin;
  final String difficulty;

  CourseDetail({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.title,
    required this.videoUrl,
    required this.durationMin,
    required this.difficulty,
  });
}
