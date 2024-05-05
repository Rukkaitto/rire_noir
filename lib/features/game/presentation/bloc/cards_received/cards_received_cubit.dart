import 'package:api/entities/playing_card.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_received_state.dart';

class CardsReceivedCubit extends Cubit<List<PlayingCard>> {
  CardsReceivedCubit() : super([]);

  void update(List<PlayingCard> cards) {
    emit(cards);
  }

  void reset() {
    emit([]);
  }
}
