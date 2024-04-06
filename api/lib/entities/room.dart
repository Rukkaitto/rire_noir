import 'package:shelf_plus/shelf_plus.dart';

class Room {
  final String pinCode;
  final int capacity;
  final int winningScore;
  final WebSocketSession host;
  final List<WebSocketSession> users = [];

  Room({
    required this.pinCode,
    required this.capacity,
    required this.winningScore,
    required this.host,
  });

  void addUser(WebSocketSession user) {
    users.add(user);
  }
}
