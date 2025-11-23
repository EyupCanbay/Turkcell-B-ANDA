import '../../data/models/category_model.dart';
import '../../data/models/lesson_model.dart';

abstract class HomeRepository {
  Future<List<CategoryModel>> getCategories();
  Future<List<LessonModel>> getLessons();
}
