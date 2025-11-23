import 'package:bi_anda/features/course_detail/domain/repository/course_detail_repository.dart';

import '../../domain/entities/course_detail.dart';
import '../datasources/course_detail_remote_data_source.dart';

class CourseDetailRepositoryImpl implements CourseDetailRepository {
  final CourseDetailRemoteDataSource remote;

  CourseDetailRepositoryImpl(this.remote);

  @override
  Future<CourseDetail> getCourseDetail(int id) {
    return remote.getCourseDetail(id);
  }
}
