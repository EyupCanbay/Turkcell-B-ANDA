import 'package:bi_anda/features/course_detail/domain/repository/course_detail_repository.dart';

import '../entities/course_detail.dart';

class GetCourseDetailUseCase {
  final CourseDetailRepository repo;

  GetCourseDetailUseCase(this.repo);

  Future<CourseDetail> call(int id) async {
    return repo.getCourseDetail(id);
  }
}
