part of 'cards_dealt_cubit.dart';

sealed class CardsDealtState extends Equatable {
  const CardsDealtState();

  @override
  List<Object> get props => [];
}

class CardsDealtInitial extends CardsDealtState {}

class CardsDealt extends CardsDealtState {
  final List<PlayingCard> cards;

  const CardsDealt({required this.cards});

  @override
  List<Object> get props => [cards];
}
