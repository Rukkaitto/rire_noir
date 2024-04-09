import 'package:api/entities/playing_card.dart';

class Round {
  PlayingCard blackCard;
  List<PlayingCard> whiteCards;

  int get playedCardCount => whiteCards.length;

  Round({
    required this.blackCard,
    required this.whiteCards,
  });

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      blackCard: PlayingCard.fromJson(json['blackCard']),
      whiteCards: (json['whiteCards'] as List)
          .map((card) => PlayingCard.fromJson(card))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blackCard': blackCard.toJson(),
      'whiteCards': whiteCards.map((card) => card.toJson()).toList(),
    };
  }
}
