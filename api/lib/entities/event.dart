enum Event {
  joinRoom,
  ready,
  selectCard,
  selectWinner,
}

extension EventExtension on Event {
  static Event fromJson(String event) {
    switch (event) {
      case 'joinRoom':
        return Event.joinRoom;
      case 'ready':
        return Event.ready;
      case 'selectCard':
        return Event.selectCard;
      case 'selectWinner':
        return Event.selectWinner;
      default:
        throw Exception('Event $event not found');
    }
  }

  String toJson() {
    switch (this) {
      case Event.joinRoom:
        return 'joinRoom';
      case Event.ready:
        return 'ready';
      case Event.selectCard:
        return 'selectCard';
      case Event.selectWinner:
        return 'selectWinner';
    }
  }
}
