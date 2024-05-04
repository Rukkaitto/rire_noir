import 'package:api/entities/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<Game?> {
  GameCubit() : super(null);

  void setGame(Game game) {
    emit(game);
  }
}
