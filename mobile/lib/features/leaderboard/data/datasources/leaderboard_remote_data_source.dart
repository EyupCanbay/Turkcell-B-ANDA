import 'package:dio/dio.dart';
import '../models/leaderboard_user_model.dart';

abstract class LeaderboardRemoteDataSource {
  Future<List<LeaderboardUserModel>> getLeaderboard();
}

class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {
  final Dio dio;

  LeaderboardRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LeaderboardUserModel>> getLeaderboard() async {
    final response = await dio.get('/leaderboard');

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((json) => LeaderboardUserModel.fromJson(json)).toList();
    } else {
      throw Exception('Sıralama yüklenemedi');
    }
  }
}
