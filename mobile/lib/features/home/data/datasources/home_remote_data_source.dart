import 'package:dio/dio.dart';
import '../models/category_model.dart';
import '../models/lesson_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<LessonModel>> getLessons();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get('/categories');

    final List data = response.data ?? [];
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<List<LessonModel>> getLessons() async {
    final response = await dio.get('/lessons');

    final List data = response.data ?? [];
    return data.map((e) => LessonModel.fromJson(e)).toList();
  }
}
