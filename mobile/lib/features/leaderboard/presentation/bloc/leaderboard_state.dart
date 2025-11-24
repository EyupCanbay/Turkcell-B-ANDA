import 'package:equatable/equatable.dart';
import '../../domain/entities/leaderboard_user.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();
  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardUser> topThree; // İlk 3 (Podium için)
  final List<LeaderboardUser> rest; // Listenin kalanı

  const LeaderboardLoaded({required this.topThree, required this.rest});

  @override
  List<Object> get props => [topThree, rest];
}

class LeaderboardError extends LeaderboardState {
  final String message;
  const LeaderboardError(this.message);
  @override
  List<Object> get props => [message];
}
