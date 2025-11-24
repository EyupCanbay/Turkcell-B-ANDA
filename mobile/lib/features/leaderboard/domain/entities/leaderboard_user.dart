import 'package:equatable/equatable.dart';

class LeaderboardUser extends Equatable {
  final int id;
  final String name;
  final int score;
  final int rank;
  final String? profileImageUrl;

  const LeaderboardUser({
    required this.id,
    required this.name,
    required this.score,
    required this.rank,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [id, name, score, rank, profileImageUrl];
}
