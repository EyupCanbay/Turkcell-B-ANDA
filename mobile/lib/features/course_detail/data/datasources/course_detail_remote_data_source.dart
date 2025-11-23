import 'package:dio/dio.dart';
import '../models/course_detail_model.dart';

abstract class CourseDetailRemoteDataSource {
  Future<CourseDetailModel> getCourseDetail(int id);
}

class CourseDetailRemoteDataSourceImpl implements CourseDetailRemoteDataSource {
  final Dio dio;

  CourseDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<CourseDetailModel> getCourseDetail(int id) async {
    final response = await dio.get("/lessons/$id");

    return CourseDetailModel.fromJson(response.data);
  }
}
