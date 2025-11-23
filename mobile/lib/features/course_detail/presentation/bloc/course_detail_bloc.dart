import 'package:flutter_bloc/flutter_bloc.dart';
import 'course_detail_event.dart';
import 'course_detail_state.dart';
import '../../domain/usecases/get_course_detail_usecase.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final GetCourseDetailUseCase getDetail;

  CourseDetailBloc(this.getDetail) : super(CourseDetailState()) {
    on<LoadCourseDetail>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));

      try {
        final data = await getDetail(event.id);
        emit(state.copyWith(isLoading: false, course: data));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });
  }
}
