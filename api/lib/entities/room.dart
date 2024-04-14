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
  final int whiteCardCount;
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
  List<Player> get allPlayers {
    final allPlayers = players.toList();
    if (master != null) {
      allPlayers.add(master!);
    }
    return allPlayers;
  }

  Room({
    required this.id,
    required this.winningScore,
    this.whiteCardCount = 3,
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

  bool canIPlay(String playerId) {
    final playedCardsCount = currentRound.whiteCards[playerId]?.length ?? 0;
    final requiredCardsCount = currentBlackCard.requiredWhiteCardCount;
    final isMaster = amITheMaster(playerId);

    return !isMaster &&
        mode == Mode.active &&
        playedCardsCount < requiredCardsCount;
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  void startGame() {
    // Load cards
    blackCards = CardLoader.loadCards(path: 'data/black_cards.json');
    whiteCards = CardLoader.loadCards(path: 'data/white_cards.json');

    dealWhiteCards();

    // Pick a master once the cards have been dealt
    master = players[Random().nextInt(playerCount)];
    players.remove(master);

    final round = Round(
      blackCard: pickBlackCard(),
      whiteCards: players.fold({}, (map, player) {
        map[player.id] = [];
        return map;
      }),
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
    // This is done before the master is changed so that the master doesn't get a card
    dealWhiteCards();

    // Re-add the master to the players list
    final masterIndex = players.indexWhere((player) => player.id == master!.id);
    players.add(master!);

    // Pick a new master
    master = players[masterIndex + 1 % playerCount];
    players.remove(master);

    final round = Round(
      blackCard: pickBlackCard(),
      whiteCards: players.fold({}, (map, player) {
        map[player.id] = [];
        return map;
      }),
    );
    rounds.add(round);

    mode = Mode.active;
  }

  void dealWhiteCards() {
    for (var player in players) {
      final needed = whiteCardCount - player.cards.length;

      // Remove `count` cards from the white cards deck
      final dealtCards = whiteCards.sublist(0, needed);

      // Assign the player id to the cards
      for (var card in dealtCards) {
        card.playerId = player.id;
      }

      whiteCards.removeRange(0, needed);

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

    if (!currentRound.whiteCards.containsKey(playerId)) {
      currentRound.whiteCards[playerId] = [];
    }

    currentRound.whiteCards[playerId]!.add(card);

    return currentRound.donePlayersCount == playerCount;
  }

  void broadcastToMaster() {
    final encodedRoom = jsonEncode(toJson());
    master?.ws?.send(encodedRoom);
  }

  void broadcastChange() {
    final encodedRoom = jsonEncode(toJson());

    for (var player in players) {
      player.ws?.send(encodedRoom);
    }

    master?.ws?.send(encodedRoom);
  }
}
