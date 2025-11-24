import '../../domain/entities/leaderboard_user.dart';

class LeaderboardUserModel extends LeaderboardUser {
  const LeaderboardUserModel({
    required super.id,
    required super.name,
    required super.score,
    required super.rank,
    super.profileImageUrl,
  });

  factory LeaderboardUserModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      score: json['total_points'] ?? 0,
      rank: json['rank'] ?? 0,
      profileImageUrl: json['profile_image_url'],
    );
  }
}
