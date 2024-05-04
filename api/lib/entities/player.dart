import 'package:api/entities/web_socket_client.dart';
import 'package:shelf_plus/shelf_plus.dart';

import 'playing_card.dart';

class Player {
  String id;
  String? name;
  bool isReady;
  int score;
  List<PlayingCard> cards;
  final String gameId;
  final WebSocketClient? client;

  get ws => client?.ws;

  Player({
    required this.id,
    this.name,
    this.isReady = false,
    required this.score,
    List<PlayingCard>? cards,
    WebSocketSession? ws,
    required this.gameId,
  })  : cards = cards ?? [],
        client = ws != null ? WebSocketClient(ws: ws) : null;

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
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
      'name': name,
      'isReady': isReady,
      'score': score,
      'cards': cards.map((card) => card.toJson()).toList(),
      'gameId': gameId,
    };
  }
}
