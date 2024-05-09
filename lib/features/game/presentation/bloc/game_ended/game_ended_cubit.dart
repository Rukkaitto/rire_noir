import 'package:api/entities/player_with_score.dart';
import 'package:api/entities/server_message.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_ended_state.dart';

class GameEndedCubit extends Cubit<GameEndedState> {
  GameEndedCubit() : super(GameEndedInitial());

  void update(GameEndedMessage message) {
    emit(GameEndedReceived(
      winnerName: message.winnerName,
      leaderboard: message.leaderboard,
    ));
  }

  void reset() {
    emit(GameEndedInitial());
  }
}
