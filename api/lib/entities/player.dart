import 'package:api/entities/card.dart';
import 'package:shelf_plus/shelf_plus.dart';

class Player {
  String id;
  bool isReady;
  final int score;
  List<Card> cards;
  final WebSocketSession? ws;
  final String roomId;

  Player({
    required this.id,
    this.isReady = false,
    required this.score,
    List<Card>? cards,
    this.ws,
    required this.roomId,
  }) : cards = cards ?? [];

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      isReady: json['isReady'],
      score: json['score'],
      cards:
          (json['cards'] as List).map((card) => Card.fromJson(card)).toList(),
      roomId: json['roomId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isReady': isReady,
      'score': score,
      'cards': cards.map((card) => card.toJson()).toList(),
      'roomId': roomId,
    };
  }
}
