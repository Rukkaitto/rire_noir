import 'package:api/entities/mode.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/game.dart';
import 'package:api/entities/round.dart';
import 'package:test/test.dart';

void main() {
  group('Game', () {
    late Game tGame;
    late Game tGameStarted;

    setUp(() {
      tGame = Game(
        id: 'F9A9LE',
        winningScore: 10,
        whiteCardCount: 3,
        master: Player(
          id: 'player1',
          isReady: true,
          score: 0,
          cards: [
            PlayingCard(
              id: 1,
              text: 'Hello',
            ),
          ],
          gameId: '1',
        ),
        players: [
          Player(
            id: 'player2',
            isReady: false,
            score: 0,
            cards: [],
            gameId: '1',
          ),
          Player(
            id: 'player3',
            isReady: false,
            score: 0,
            cards: [],
            gameId: '1',
          ),
        ],
        rounds: [],
        mode: Mode.active,
        whiteCards: [],
        blackCards: [],
      );

      tGameStarted = Game(
        id: 'F9A9LE',
        winningScore: 2,
        master: Player(
          id: 'player1',
          isReady: true,
          score: 0,
          cards: [
            PlayingCard(
              id: 1,
              text: 'card1',
              playerId: 'player1',
            ),
            PlayingCard(
              id: 2,
              text: 'card2',
              playerId: 'player1',
            ),
            PlayingCard(
              id: 3,
              text: 'card3',
              playerId: 'player1',
            ),
          ],
          gameId: '1',
        ),
        players: [
          Player(
            id: 'player2',
            isReady: true,
            score: 0,
            cards: [
              PlayingCard(
                id: 4,
                text: 'card4',
                playerId: 'player2',
              ),
              PlayingCard(
                id: 5,
                text: 'card5',
                playerId: 'player2',
              ),
              PlayingCard(
                id: 6,
                text: 'card6',
                playerId: 'player2',
              ),
            ],
            gameId: '1',
          ),
          Player(
            id: 'player3',
            isReady: true,
            score: 0,
            cards: [
              PlayingCard(
                id: 7,
                text: 'card7',
                playerId: 'player3',
              ),
              PlayingCard(
                id: 8,
                text: 'card8',
                playerId: 'player3',
              ),
              PlayingCard(
                id: 9,
                text: 'card9',
                playerId: 'player3',
              ),
            ],
            gameId: '1',
          ),
        ],
        rounds: [
          Round(
            blackCard: PlayingCard(
              id: 1,
              text: 'Hello, %@!',
            ),
            whiteCards: {},
          ),
        ],
        mode: Mode.active,
        whiteCards: List.generate(
          50,
          (index) => PlayingCard(id: index, text: 'card$index'),
        ),
        blackCards: [
          PlayingCard(
            id: 1,
            text: 'Hello, %@, %@!',
          ),
        ],
      );
    });

    test('fromJson', () {
      final json = {
        'id': 'F9A9LE',
        'winningScore': 10,
        'master': {
          'id': 'player1',
          'isReady': true,
          'score': 0,
          'cards': [
            {
              'id': 1,
              'text': 'Hello',
            },
          ],
          'gameId': '1',
        },
        'players': [
          {
            'id': 'player1',
            'isReady': false,
            'score': 0,
            'cards': [
              {
                'id': 2,
                'text': 'World',
              },
            ],
            'gameId': '1',
          },
        ],
        'rounds': [
          {
            'blackCard': {
              'id': 1,
              'text': 'Hello, %@, %@!',
            },
            'whiteCards': {
              'player1': [
                {
                  'id': 1,
                  'text': 'Hello',
                }
              ],
              'player2': [
                {
                  'id': 2,
                  'text': 'World',
                }
              ]
            },
          },
        ],
        'mode': 0,
      };

      final game = Game.fromJson(json);

      expect(game.id, 'F9A9LE');
      expect(game.winningScore, 10);
      expect(game.master?.id, 'player1');
      expect(game.players.length, 1);
      expect(game.rounds.length, 1);
      expect(game.blackCards.length, 0);
      expect(game.whiteCards.length, 0);
      expect(game.mode, Mode.active);
    });

    test('toJson', () {
      final json = tGameStarted.toJson();

      expect(json['id'], 'F9A9LE');
      expect(json['winningScore'], 2);
      expect(json['master']['id'], 'player1');
      expect(json['players'].length, 2);
      expect(json['rounds'].length, 1);
      expect(json['mode'], 0);
    });

    test('playerCount', () {
      expect(tGameStarted.playerCount, 2);
    });

    test('isEveryoneReady', () {
      expect(tGameStarted.isEveryoneReady, true);
    });

    test('isGameStarted', () {
      expect(tGameStarted.isGameStarted, true);
    });

    test('readyPlayerCount', () {
      expect(tGameStarted.readyPlayerCount, 2);
    });

    test('currentRound', () {
      expect(tGameStarted.currentRound.blackCard.id, 1);
      expect(tGameStarted.currentRound.blackCard.text, 'Hello, %@!');
      expect(tGameStarted.currentRound.whiteCards.length, 0);
    });

    test('currentBlackCard', () {
      expect(tGameStarted.currentBlackCard.id, 1);
      expect(tGameStarted.currentBlackCard.text, 'Hello, %@!');
    });

    test('amITheMaster', () {
      expect(tGameStarted.amITheMaster('player1'), true);
    });

    test('addPlayer', () {
      final player = Player(
        id: 'player1',
        isReady: true,
        score: 0,
        cards: [
          PlayingCard(
            id: 1,
            text: 'Hello',
          ),
        ],
        gameId: '1',
      );

      tGameStarted.addPlayer(player);

      expect(tGameStarted.players.length, 3);
    });

    test('startGame', () {
      tGame.startGame();

      expect(tGame.rounds.length, 1);
      expect(tGame.blackCards.isNotEmpty, true);
      expect(tGame.whiteCards.isNotEmpty, true);
    });

    test('startReview', () {
      tGameStarted.startReview();

      expect(tGameStarted.mode, Mode.review);
    });

    test('selectWinner', () {
      final player = tGameStarted.players[0];
      tGameStarted.selectWinner(player.id);

      expect(player.score, 1);
    });

    test('nextRound', () {
      tGameStarted.nextRound();

      expect(tGameStarted.rounds.length, 2);
      expect(tGameStarted.master?.id, 'player2');
      expect(tGameStarted.players.length, 2);
    });

    test('dealWhiteCards', () {
      final player = tGameStarted.players[0];
      player.cards = [];

      tGameStarted.dealWhiteCards();

      expect(player.cards.length, 3);
      expect(tGameStarted.whiteCards.length, 47);

      player.cards = [
        PlayingCard(
          id: 1,
          text: 'card1',
          playerId: player.id,
        ),
        PlayingCard(
          id: 2,
          text: 'card2',
          playerId: player.id,
        ),
      ];

      tGameStarted.dealWhiteCards();

      expect(player.cards.length, 3);
      expect(tGameStarted.whiteCards.length, 46);
      expect(player.cards.every((card) => card.playerId == player.id), true);
    });

    test('pickBlackCard', () {
      final card = tGameStarted.pickBlackCard();

      expect(card.id, 1);
      expect(card.text, 'Hello, %@, %@!');
      expect(tGameStarted.blackCards.length, 0);
    });

    test('playCard', () {
      var isRoundOver = tGameStarted.playCard('player2', 4);
      expect(isRoundOver, false);
      isRoundOver = tGameStarted.playCard('player3', 7);
      expect(isRoundOver, true);

      expect(tGameStarted.players[0].cards.length, 2);
      expect(tGameStarted.players[1].cards.length, 2);
      expect(tGameStarted.currentRound.whiteCards.length, 2);
    });

    test('allPlayers', () {
      expect(tGameStarted.allPlayers.length, 3);
    });
  });
}
