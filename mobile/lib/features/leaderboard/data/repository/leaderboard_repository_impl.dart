import 'package:bi_anda/features/leaderboard/domain/repository/leaderboard_repository.dart';
import '../../domain/entities/leaderboard_user.dart';
import '../datasources/leaderboard_remote_data_source.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final LeaderboardRemoteDataSource remoteDataSource;

  LeaderboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LeaderboardUser>> getLeaderboard() async {
    return await remoteDataSource.getLeaderboard();
  }
}
