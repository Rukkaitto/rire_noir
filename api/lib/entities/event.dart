enum Event {
  joinRoom,
  selectCard,
  selectWinner,
}

extension EventExtension on Event {
  static Event fromJson(String event) {
    switch (event) {
      case 'joinRoom':
        return Event.joinRoom;
      case 'selectCard':
        return Event.selectCard;
      case 'selectWinner':
        return Event.selectWinner;
      default:
        throw Exception('Event $event not found');
    }
  }
}
