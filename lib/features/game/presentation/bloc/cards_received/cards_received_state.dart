part of 'cards_received_cubit.dart';

sealed class CardsReceivedState extends Equatable {
  const CardsReceivedState();

  @override
  List<Object> get props => [];
}

class CardsReceivedStopped extends CardsReceivedState {}

class CardsReceivedStarted extends CardsReceivedState {
  final List<PlayingCard> cards;

  const CardsReceivedStarted(this.cards);

  @override
  List<Object> get props => [];
}
