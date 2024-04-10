import 'package:api/entities/playing_card.dart';

class Round {
  PlayingCard blackCard;
  Map<String, List<PlayingCard>> whiteCards;

  int get donePlayersCount => whiteCards.values
      .map((cards) => cards.length)
      .where((count) => count == blackCard.requiredWhiteCardCount)
      .length;

  Round({
    required this.blackCard,
    required this.whiteCards,
  });

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      blackCard: PlayingCard.fromJson(json['blackCard']),
      whiteCards: {
        for (var entry in json['whiteCards'].entries)
          entry.key: (entry.value as List)
              .map((card) => PlayingCard.fromJson(card))
              .toList(),
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blackCard': blackCard.toJson(),
      'whiteCards': whiteCards.map((playerId, cards) {
        return MapEntry(playerId, cards.map((card) => card.toJson()).toList());
      }),
    };
  }
}
