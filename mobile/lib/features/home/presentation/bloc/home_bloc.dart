import 'package:bi_anda/features/home/domain/usecases/get_categories.dart';
import 'package:bi_anda/features/home/domain/usecases/get_lessons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategories;
  final GetLessonsUseCase getLessons;

  HomeBloc(this.getCategories, this.getLessons) : super(const HomeState()) {
    on<LoadHomeData>(_onLoad);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final categories = await getCategories();
    final lessons = await getLessons();

    emit(state.copyWith(
      isLoading: false,
      categories: categories,
      lessons: lessons,
    ));
  }

  void _onSelectCategory(SelectCategory event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }
}
