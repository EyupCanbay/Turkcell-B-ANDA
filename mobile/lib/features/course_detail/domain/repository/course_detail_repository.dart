import '../entities/course_detail.dart';

abstract class CourseDetailRepository {
  Future<CourseDetail> getCourseDetail(int id);
}
