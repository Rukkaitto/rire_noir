import 'package:api/entities/card.dart';
import 'package:equatable/equatable.dart';
import 'package:shelf_plus/shelf_plus.dart';

class Player extends Equatable {
  final int score;
  final List<Card> cards;
  final WebSocketSession? ws;
  final String roomId;

  Player({
    required this.score,
    required this.cards,
    this.ws,
    required this.roomId,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      score: json['score'],
      cards:
          (json['cards'] as List).map((card) => Card.fromJson(card)).toList(),
      roomId: json['roomId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'cards': cards.map((card) => card.toJson()).toList(),
      'roomId': roomId,
    };
  }

  @override
  List<Object?> get props => [score, roomId];
}
