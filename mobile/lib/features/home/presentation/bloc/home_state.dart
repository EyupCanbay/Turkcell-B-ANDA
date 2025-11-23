import 'package:bi_anda/features/home/data/models/category_model.dart';
import 'package:bi_anda/features/home/data/models/lesson_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<CategoryModel> categories;
  final List<LessonModel> lessons;
  final int selectedCategoryId;

  const HomeState({
    this.isLoading = false,
    this.categories = const [],
    this.lessons = const [],
    this.selectedCategoryId = -1,
  });

  HomeState copyWith({
    bool? isLoading,
    List<CategoryModel>? categories,
    List<LessonModel>? lessons,
    int? selectedCategoryId,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      lessons: lessons ?? this.lessons,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, categories, lessons, selectedCategoryId];
}
