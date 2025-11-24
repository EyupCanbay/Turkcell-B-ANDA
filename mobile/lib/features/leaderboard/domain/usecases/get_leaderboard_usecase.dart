import 'package:bi_anda/features/leaderboard/domain/repository/leaderboard_repository.dart';
import '../entities/leaderboard_user.dart';

class GetLeaderboardUseCase {
  final LeaderboardRepository repository;

  GetLeaderboardUseCase(this.repository);

  Future<List<LeaderboardUser>> call() {
    return repository.getLeaderboard();
  }
}
