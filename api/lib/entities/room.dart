import 'dart:convert';

import 'package:api/entities/player.dart';
import 'package:equatable/equatable.dart';
import 'package:shelf_plus/shelf_plus.dart';

class Room extends Equatable {
  final String id;
  final int capacity;
  final int winningScore;
  final List<Player> players;

  Room({
    required this.id,
    required this.capacity,
    required this.winningScore,
    required this.players,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      capacity: json['capacity'],
      winningScore: json['winningScore'],
      players: (json['players'] as List)
          .map((player) => Player.fromJson(player))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'capacity': capacity,
      'winningScore': winningScore,
      'players': players.map((player) => player.toJson()).toList(),
    };
  }

  void addSession(WebSocketSession user) {
    final player = Player(score: 0, cards: [], ws: user, roomId: id);

    players.add(player);
  }

  void broadcastChange() {
    for (var player in players) {
      final encodedRoom = jsonEncode(toJson());
      player.ws?.send(encodedRoom);
    }
  }

  @override
  List<Object?> get props => [id, capacity, winningScore, players];
}
