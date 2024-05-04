import 'package:api/entities/playing_card.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_dealt_state.dart';

class CardsDealtCubit extends Cubit<CardsDealtState> {
  CardsDealtCubit() : super(CardsDealtInitial());

  void newCardsWereDealt(List<PlayingCard> cards) {
    emit(CardsDealt(cards: cards));
  }

  void reset() {
    emit(CardsDealtInitial());
  }
}
