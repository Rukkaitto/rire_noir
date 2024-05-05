import 'package:api/entities/game.dart';
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
      case ServerEvent.roundWon:
        return RoundWonMessage.fromJson(json);
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

class RoundWonMessage extends ServerMessage {
  RoundWonMessage() : super(ServerEvent.roundWon);

  @override
  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
    };
  }

  factory RoundWonMessage.fromJson(Map<String, dynamic> json) {
    return RoundWonMessage();
  }
}
