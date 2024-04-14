import 'package:api/entities/mode.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/room.dart';
import 'package:api/entities/round.dart';
import 'package:test/test.dart';

void main() {
  group('Room', () {
    late Room tRoom;
    late Room tRoomStarted;

    setUp(() {
      tRoom = Room(
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
          roomId: '1',
        ),
        players: [
          Player(
            id: 'player2',
            isReady: false,
            score: 0,
            cards: [],
            roomId: '1',
          ),
          Player(
            id: 'player3',
            isReady: false,
            score: 0,
            cards: [],
            roomId: '1',
          ),
        ],
        rounds: [],
        mode: Mode.active,
        whiteCards: [],
        blackCards: [],
      );

      tRoomStarted = Room(
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
          roomId: '1',
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
            roomId: '1',
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
            roomId: '1',
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
          'roomId': '1',
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
            'roomId': '1',
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

      final room = Room.fromJson(json);

      expect(room.id, 'F9A9LE');
      expect(room.winningScore, 10);
      expect(room.master?.id, 'player1');
      expect(room.players.length, 1);
      expect(room.rounds.length, 1);
      expect(room.blackCards.length, 0);
      expect(room.whiteCards.length, 0);
      expect(room.mode, Mode.active);
    });

    test('toJson', () {
      final json = tRoomStarted.toJson();

      expect(json['id'], 'F9A9LE');
      expect(json['winningScore'], 2);
      expect(json['master']['id'], 'player1');
      expect(json['players'].length, 2);
      expect(json['rounds'].length, 1);
      expect(json['mode'], 0);
    });

    test('playerCount', () {
      expect(tRoomStarted.playerCount, 2);
    });

    test('isEveryoneReady', () {
      expect(tRoomStarted.isEveryoneReady, true);
    });

    test('isGameStarted', () {
      expect(tRoomStarted.isGameStarted, true);
    });

    test('readyPlayerCount', () {
      expect(tRoomStarted.readyPlayerCount, 2);
    });

    test('currentRound', () {
      expect(tRoomStarted.currentRound.blackCard.id, 1);
      expect(tRoomStarted.currentRound.blackCard.text, 'Hello, %@!');
      expect(tRoomStarted.currentRound.whiteCards.length, 0);
    });

    test('currentBlackCard', () {
      expect(tRoomStarted.currentBlackCard.id, 1);
      expect(tRoomStarted.currentBlackCard.text, 'Hello, %@!');
    });

    test('amITheMaster', () {
      expect(tRoomStarted.amITheMaster('player1'), true);
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
        roomId: '1',
      );

      tRoomStarted.addPlayer(player);

      expect(tRoomStarted.players.length, 3);
    });

    test('startGame', () {
      tRoom.startGame();

      expect(tRoom.rounds.length, 1);
      expect(tRoom.blackCards.isNotEmpty, true);
      expect(tRoom.whiteCards.isNotEmpty, true);
    });

    test('startReview', () {
      tRoomStarted.startReview();

      expect(tRoomStarted.mode, Mode.review);
    });

    test('selectWinner', () {
      final player = tRoomStarted.players[0];
      tRoomStarted.selectWinner(player.id);

      expect(player.score, 1);
    });

    test('nextRound', () {
      tRoomStarted.nextRound();

      expect(tRoomStarted.rounds.length, 2);
      expect(tRoomStarted.master?.id, 'player2');
      expect(tRoomStarted.players.length, 2);
    });

    test('dealWhiteCards', () {
      final player = tRoomStarted.players[0];
      player.cards = [];

      tRoomStarted.dealWhiteCards();

      expect(player.cards.length, 3);
      expect(tRoomStarted.whiteCards.length, 47);

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

      tRoomStarted.dealWhiteCards();

      expect(player.cards.length, 3);
      expect(tRoomStarted.whiteCards.length, 46);
      expect(player.cards.every((card) => card.playerId == player.id), true);
    });

    test('pickBlackCard', () {
      final card = tRoomStarted.pickBlackCard();

      expect(card.id, 1);
      expect(card.text, 'Hello, %@, %@!');
      expect(tRoomStarted.blackCards.length, 0);
    });

    test('playCard', () {
      var isRoundOver = tRoomStarted.playCard('player2', 4);
      expect(isRoundOver, false);
      isRoundOver = tRoomStarted.playCard('player3', 7);
      expect(isRoundOver, true);

      expect(tRoomStarted.players[0].cards.length, 2);
      expect(tRoomStarted.players[1].cards.length, 2);
      expect(tRoomStarted.currentRound.whiteCards.length, 2);
    });

    test('allPlayers', () {
      expect(tRoomStarted.allPlayers.length, 3);
    });
  });
}
