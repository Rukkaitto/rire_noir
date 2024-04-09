import 'dart:convert';
import 'dart:math';

import 'package:api/entities/player.dart';
import 'package:api/entities/round.dart';
import 'package:api/utils/card_loader.dart';

import 'mode.dart';
import 'playing_card.dart';

class Room {
  final String id;
  final int winningScore;
  Player? master;
  List<Player> players;
  List<Round> rounds;
  List<PlayingCard> blackCards;
  List<PlayingCard> whiteCards;
  Mode mode;

  int get playerCount => players.length;
  bool get isEveryoneReady => players.every((player) => player.isReady);
  bool get isGameStarted => rounds.isNotEmpty;
  int get readyPlayerCount => players.where((player) => player.isReady).length;
  Round get currentRound => rounds.last;
  PlayingCard get currentBlackCard => currentRound.blackCard;
  int get currentRoundPlayerCount => playerCount - 1;

  Room({
    required this.id,
    required this.winningScore,
    this.master,
    List<Player>? players,
    List<Round>? rounds,
    List<PlayingCard>? blackCards,
    List<PlayingCard>? whiteCards,
    Mode? mode,
  })  : players = players ?? [],
        rounds = rounds ?? [],
        blackCards = blackCards ?? [],
        whiteCards = whiteCards ?? [],
        mode = mode ?? Mode.active;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      winningScore: json['winningScore'],
      master: json['master'] != null ? Player.fromJson(json['master']) : null,
      players: (json['players'] as List)
          .map((player) => Player.fromJson(player))
          .toList(),
      rounds: (json['rounds'] as List)
          .map((round) => Round.fromJson(round))
          .toList(),
      mode: json['mode'] != null ? Mode.values[json['mode']] : Mode.active,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'winningScore': winningScore,
      'master': master?.toJson(),
      'players': players.map((player) => player.toJson()).toList(),
      'rounds': rounds.map((round) => round.toJson()).toList(),
      'mode': mode.index,
    };
  }

  bool amITheMaster(String playerId) {
    return master?.id == playerId;
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  void startGame() {
    master = players[Random().nextInt(playerCount)];
    blackCards = CardLoader.loadCards(path: 'data/black_cards.json');
    whiteCards = CardLoader.loadCards(path: 'data/white_cards.json');
    dealWhiteCards(each: 3);
    final round = Round(
      blackCard: pickBlackCard(),
      whiteCards: [],
    );
    rounds.add(round);
  }

  void startReview() {
    mode = Mode.review;
  }

  void selectWinner(String winnerId) {
    final winner = players.firstWhere((player) => player.id == winnerId);
    winner.score += 1;

    if (winner.score == winningScore) {
      mode = Mode.finished;
    } else {
      nextRound();
    }
  }

  void nextRound() {
    final round = Round(
      blackCard: pickBlackCard(),
      whiteCards: [],
    );
    rounds.add(round);
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

  PlayingCard pickBlackCard() {
    final card = blackCards.removeAt(0);
    return card;
  }

  // Returns true if all players have played a card
  bool playCard(String playerId, int cardId) {
    final player = players.firstWhere((player) => player.id == playerId);
    final card = player.cards.firstWhere((card) => card.id == cardId);
    player.cards.remove(card);
    card.playerId = playerId;
    currentRound.whiteCards.add(card);

    if (currentRound.playedCardCount == currentRoundPlayerCount) {
      return true;
    }

    return false;
  }

  void broadcastChange() {
    for (var player in players) {
      final encodedRoom = jsonEncode(toJson());
      player.ws?.send(encodedRoom);
    }
  }
}
