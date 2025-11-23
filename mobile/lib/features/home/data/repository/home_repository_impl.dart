import 'package:bi_anda/features/home/domain/repository/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/category_model.dart';
import '../models/lesson_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<List<CategoryModel>> getCategories() {
    return remote.getCategories();
  }

  @override
  Future<List<LessonModel>> getLessons() {
    return remote.getLessons();
  }
}
