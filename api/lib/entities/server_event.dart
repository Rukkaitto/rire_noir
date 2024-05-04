/// An event that is sent from the server to the client
enum ServerEvent {
  gameChanged,
  cardsDealt,
}

extension ServerEventExtension on ServerEvent {
  static ServerEvent fromJson(String event) {
    switch (event) {
      case 'gameChanged':
        return ServerEvent.gameChanged;
      case 'cardsDealt':
        return ServerEvent.cardsDealt;
      default:
        throw Exception('Event $event not found');
    }
  }

  String toJson() {
    switch (this) {
      case ServerEvent.gameChanged:
        return 'gameChanged';
      case ServerEvent.cardsDealt:
        return 'cardsDealt';
    }
  }
}
