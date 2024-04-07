import 'dart:convert';
import 'dart:math';

import 'package:api/entities/card.dart';
import 'package:api/entities/player.dart';

class Room {
  final String id;
  final int winningScore;
  Player? master;
  List<Player> players;
  int currentRound;
  List<Card> blackCards;

  int get playerCount => players.length;
  bool get isEveryoneReady => players.every((player) => player.isReady);
  bool get isGameStarted => currentRound > 0;
  int get readyPlayerCount => players.where((player) => player.isReady).length;

  Room({
    required this.id,
    required this.winningScore,
    this.master,
    required this.players,
    this.currentRound = 0,
    required this.blackCards,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      winningScore: json['winningScore'],
      master: json['master'] != null ? Player.fromJson(json['master']) : null,
      players: (json['players'] as List)
          .map((player) => Player.fromJson(player))
          .toList(),
      currentRound: json['currentRound'],
      blackCards: (json['blackCards'] as List)
          .map((card) => Card.fromJson(card))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'winningScore': winningScore,
      'master': master?.toJson(),
      'players': players.map((player) => player.toJson()).toList(),
      'currentRound': currentRound,
      'blackCards': blackCards.map((card) => card.toJson()).toList(),
    };
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  void startGame() {
    currentRound = 1;
    master = players[Random().nextInt(playerCount)];
    broadcastChange();
  }

  void broadcastChange() {
    for (var player in players) {
      final encodedRoom = jsonEncode(toJson());
      player.ws?.send(encodedRoom);
    }
  }
}
