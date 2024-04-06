enum Event {
  createRoom,
  joinRoom,
}

extension EventExtension on Event {
  static Event fromJson(String event) {
    switch (event) {
      case 'createRoom':
        return Event.createRoom;
      case 'joinRoom':
        return Event.joinRoom;
      default:
        throw Exception('Event $event not found');
    }
  }
}
