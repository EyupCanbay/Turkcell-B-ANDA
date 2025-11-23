import 'package:bi_anda/features/home/domain/repository/home_repository.dart';
import '../../data/models/lesson_model.dart';

class GetLessonsUseCase {
  final HomeRepository repository;

  GetLessonsUseCase(this.repository);

  Future<List<LessonModel>> call() {
    return repository.getLessons();
  }
}
