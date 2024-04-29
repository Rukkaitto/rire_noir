/// An event that is sent from the client to the server
enum ClientEvent {
  joinRoom,
  setName,
  ready,
  selectCard,
  selectWinner,
}

extension ClientEventExtension on ClientEvent {
  static ClientEvent fromMessageJson(Map<String, dynamic> json) {
    final event = json['event'] as String;

    switch (event) {
      case 'joinRoom':
        return ClientEvent.joinRoom;
      case 'setName':
        return ClientEvent.setName;
      case 'ready':
        return ClientEvent.ready;
      case 'selectCard':
        return ClientEvent.selectCard;
      case 'selectWinner':
        return ClientEvent.selectWinner;
      default:
        throw Exception('Event $event not found');
    }
  }

  String toJson() {
    switch (this) {
      case ClientEvent.joinRoom:
        return 'joinRoom';
      case ClientEvent.setName:
        return 'setName';
      case ClientEvent.ready:
        return 'ready';
      case ClientEvent.selectCard:
        return 'selectCard';
      case ClientEvent.selectWinner:
        return 'selectWinner';
    }
  }
}
