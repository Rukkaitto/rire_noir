import 'package:shelf_plus/shelf_plus.dart';

import 'playing_card.dart';

class Player {
  String id;
  bool isReady;
  int score;
  List<PlayingCard> cards;
  final WebSocketSession? ws;
  final String gameId;

  Player({
    required this.id,
    this.isReady = false,
    required this.score,
    List<PlayingCard>? cards,
    this.ws,
    required this.gameId,
  }) : cards = cards ?? [];

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      isReady: json['isReady'],
      score: json['score'],
      cards: (json['cards'] as List)
          .map((card) => PlayingCard.fromJson(card))
          .toList(),
      gameId: json['gameId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isReady': isReady,
      'score': score,
      'cards': cards.map((card) => card.toJson()).toList(),
      'gameId': gameId,
    };
  }
}
