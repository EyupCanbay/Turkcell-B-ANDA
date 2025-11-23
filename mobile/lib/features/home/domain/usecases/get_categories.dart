import 'package:bi_anda/features/home/domain/repository/home_repository.dart';
import '../../data/models/category_model.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryModel>> call() {
    return repository.getCategories();
  }
}
