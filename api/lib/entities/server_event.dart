/// An event that is sent from the server to the client
enum ServerEvent {
  gameChanged,
  roundWon,
  cardsReceived,
  gameEnded,
}

extension ServerEventExtension on ServerEvent {
  static ServerEvent fromJson(String event) {
    switch (event) {
      case 'gameChanged':
        return ServerEvent.gameChanged;
      case 'roundWon':
        return ServerEvent.roundWon;
      case 'cardsReceived':
        return ServerEvent.cardsReceived;
      case 'gameEnded':
        return ServerEvent.gameEnded;
      default:
        throw Exception('Event $event not found');
    }
  }

  String toJson() {
    switch (this) {
      case ServerEvent.gameChanged:
        return 'gameChanged';
      case ServerEvent.roundWon:
        return 'roundWon';
      case ServerEvent.cardsReceived:
        return 'cardsReceived';
      case ServerEvent.gameEnded:
        return 'gameEnded';
    }
  }
}
