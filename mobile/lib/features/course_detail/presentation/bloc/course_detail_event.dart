abstract class CourseDetailEvent {}

class LoadCourseDetail extends CourseDetailEvent {
  final int id;
  LoadCourseDetail(this.id);
}
