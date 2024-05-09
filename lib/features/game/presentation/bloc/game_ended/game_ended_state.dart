part of 'game_ended_cubit.dart';

sealed class GameEndedState extends Equatable {
  const GameEndedState();

  @override
  List<Object> get props => [];
}

class GameEndedInitial extends GameEndedState {}

class GameEndedReceived extends GameEndedState {
  final String winnerName;
  final List<PlayerWithScore> leaderboard;

  const GameEndedReceived({
    required this.winnerName,
    required this.leaderboard,
  });

  @override
  List<Object> get props => [winnerName, leaderboard];
}
