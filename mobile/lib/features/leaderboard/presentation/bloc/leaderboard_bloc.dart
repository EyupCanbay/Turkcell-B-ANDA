import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_leaderboard_usecase.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboardUseCase getLeaderboardUseCase;

  LeaderboardBloc(this.getLeaderboardUseCase) : super(LeaderboardInitial()) {
    on<LoadLeaderboardEvent>((event, emit) async {
      emit(LeaderboardLoading());
      try {
        final users = await getLeaderboardUseCase();

        // Sıralama logic'i (Puan'a göre azalan sırala)
        users.sort((a, b) => b.score.compareTo(a.score));

        // İlk 3 ve diğerleri olarak ayır
        final topThree = users.take(3).toList();
        final rest = users.skip(3).toList();

        emit(LeaderboardLoaded(topThree: topThree, rest: rest));
      } catch (e) {
        emit(LeaderboardError("Sıralama yüklenirken hata oluştu: $e"));
      }
    });
  }
}
