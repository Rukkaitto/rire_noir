import 'package:api/entities/game.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/server_event.dart';

/// A message that is sent from the server to the client
sealed class ServerMessage {
  final ServerEvent event;

  ServerMessage(this.event);

  Map<String, dynamic> toJson();

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    final event = ServerEventExtension.fromJson(json['event']);

    switch (event) {
      case ServerEvent.gameChanged:
        return GameChangedMessage.fromJson(json);
      case ServerEvent.cardsDealt:
        return CardsDealtMessage.fromJson(json);
    }
  }
}

class GameChangedMessage extends ServerMessage {
  final Game game;

  GameChangedMessage({required this.game}) : super(ServerEvent.gameChanged);

  @override
  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'game': game.toJson(),
    };
  }

  factory GameChangedMessage.fromJson(Map<String, dynamic> json) {
    return GameChangedMessage(
      game: Game.fromJson(json['game']),
    );
  }
}

class CardsDealtMessage extends ServerMessage {
  final List<PlayingCard> cards;

  CardsDealtMessage({required this.cards}) : super(ServerEvent.cardsDealt);

  @override
  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'cards': cards.map((card) => card.toJson()).toList(),
    };
  }

  factory CardsDealtMessage.fromJson(Map<String, dynamic> json) {
    return CardsDealtMessage(
      cards: (json['cards'] as List)
          .map((card) => PlayingCard.fromJson(card))
          .toList(),
    );
  }
}
