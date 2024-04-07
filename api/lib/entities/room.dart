import 'dart:convert';
import 'dart:math';

import 'package:api/entities/card.dart';
import 'package:api/entities/player.dart';
import 'package:api/utils/card_loader.dart';

class Room {
  final String id;
  final int winningScore;
  Player? master;
  List<Player> players;
  int currentRound;
  List<Card> blackCards;
  List<Card> whiteCards;

  int get playerCount => players.length;
  bool get isEveryoneReady => players.every((player) => player.isReady);
  bool get isGameStarted => currentRound > 0;
  int get readyPlayerCount => players.where((player) => player.isReady).length;

  Room({
    required this.id,
    required this.winningScore,
    this.master,
    List<Player>? players,
    this.currentRound = 0,
    List<Card>? blackCards,
    List<Card>? whiteCards,
  })  : players = players ?? [],
        blackCards = blackCards ?? [],
        whiteCards = whiteCards ?? [];

  factory Room.fromJson(Map<String, dynamic> json) {
    print(json);
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
    blackCards = CardLoader.loadCards(path: 'data/black_cards.json');
    whiteCards = CardLoader.loadCards(path: 'data/white_cards.json');
    dealWhiteCards(each: 3);
  }

  void nextRound() {
    currentRound++;
    master = players[(players.indexOf(master!) + 1) % playerCount];
    dealWhiteCards(each: 1);
  }

  void dealWhiteCards({required int each}) {
    for (var player in players) {
      // Remove `count` cards from the white cards deck
      final dealtCards = whiteCards.sublist(0, each);
      whiteCards.removeRange(0, each);

      // Add the cards to the player
      player.cards.addAll(dealtCards);
    }
  }

  void broadcastChange() {
    for (var player in players) {
      final encodedRoom = jsonEncode(toJson());
      player.ws?.send(encodedRoom);
    }
  }
}
